#!/bin/bash
# Wallet Data Build Script
# Generates tokenlist.json files from assets directories
# Usage: ./scripts/build.sh [network]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_info() {
    echo -e "INFO: $1"
}

log_success() {
    echo -e "${GREEN}OK:${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}WARNING:${NC} $1"
}

# Chain IDs for each network
get_chain_id() {
    case "$1" in
        ethereum) echo 1 ;;
        polygon) echo 137 ;;
        bsc) echo 56 ;;
        tron) echo 195 ;;
        solana) echo 101 ;;
        klever) echo 38 ;;
        *) echo 0 ;;
    esac
}

# Build tokenlist.json for a network
build_tokenlist() {
    local network="$1"
    local network_dir="$ROOT_DIR/chains/$network"
    local assets_dir="$network_dir/assets"
    local output_file="$network_dir/tokenlist.json"
    local info_file="$network_dir/info/info.json"

    if [ ! -d "$assets_dir" ]; then
        log_warning "No assets directory for $network"
        return 0
    fi

    local chain_id
    chain_id=$(get_chain_id "$network")

    local network_name="Unknown"
    if [ -f "$info_file" ]; then
        network_name=$(jq -r '.name' "$info_file" 2>/dev/null || echo "Unknown")
    fi

    local timestamp
    timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

    # Count tokens
    local token_count=0
    for asset_dir in "$assets_dir"/*/; do
        if [ -f "$asset_dir/info.json" ]; then
            ((token_count++))
        fi
    done

    log_info "Building tokenlist for $network ($token_count tokens)..."

    # Start building JSON
    local tokens_json="["
    local first=true

    for asset_dir in "$assets_dir"/*/; do
        local info_json="$asset_dir/info.json"
        if [ ! -f "$info_json" ]; then
            continue
        fi

        local address
        address=$(basename "$asset_dir")
        local name symbol decimals status website
        name=$(jq -r '.name' "$info_json" 2>/dev/null)
        symbol=$(jq -r '.symbol' "$info_json" 2>/dev/null)
        decimals=$(jq -r '.decimals' "$info_json" 2>/dev/null)
        status=$(jq -r '.status' "$info_json" 2>/dev/null)
        website=$(jq -r '.website // empty' "$info_json" 2>/dev/null)

        # Skip non-active tokens
        if [ "$status" != "active" ]; then
            continue
        fi

        # Get tags
        local tags
        tags=$(jq -c '.tags // []' "$info_json" 2>/dev/null)

        # Build logo URI
        local logo_uri="https://raw.githubusercontent.com/fbsobreira/wallet-data/main/chains/$network/assets/$address/logo.png"

        # Build extensions
        local extensions="{}"
        if [ -n "$website" ] && [ "$website" != "null" ]; then
            extensions=$(echo "$extensions" | jq --arg w "$website" '. + {website: $w}')
        fi

        # Get coingecko link if available
        local coingecko_id
        coingecko_id=$(jq -r '.links[] | select(.name == "coingecko") | .url | split("/") | last' "$info_json" 2>/dev/null || echo "")
        if [ -n "$coingecko_id" ]; then
            extensions=$(echo "$extensions" | jq --arg c "$coingecko_id" '. + {coingeckoId: $c}')
        fi

        # Build token object
        local token_obj
        token_obj=$(jq -n \
            --argjson chainId "$chain_id" \
            --arg address "$address" \
            --arg name "$name" \
            --arg symbol "$symbol" \
            --argjson decimals "$decimals" \
            --arg logoURI "$logo_uri" \
            --argjson tags "$tags" \
            --argjson extensions "$extensions" \
            '{
                chainId: $chainId,
                address: $address,
                name: $name,
                symbol: $symbol,
                decimals: $decimals,
                logoURI: $logoURI,
                tags: $tags,
                extensions: $extensions
            }')

        if [ "$first" = true ]; then
            first=false
        else
            tokens_json+=","
        fi
        tokens_json+="$token_obj"
    done

    tokens_json+="]"

    # Build complete tokenlist
    local tokenlist
    tokenlist=$(jq -n \
        --arg name "Hexis Wallet: $network_name" \
        --arg logoURI "https://raw.githubusercontent.com/fbsobreira/wallet-data/main/chains/$network/info/logo.png" \
        --arg timestamp "$timestamp" \
        --argjson tokens "$tokens_json" \
        '{
            name: $name,
            logoURI: $logoURI,
            timestamp: $timestamp,
            version: {
                major: 1,
                minor: 0,
                patch: 0
            },
            keywords: ["hexis", ($name | ascii_downcase | gsub(" "; "-"))],
            tokens: $tokens
        }')

    echo "$tokenlist" | jq '.' > "$output_file"
    log_success "Built $output_file ($token_count tokens)"
}

# Build combined tokenlist
build_combined() {
    log_info "Building combined tokenlist..."

    local output_file="$ROOT_DIR/chains/tokenlist.json"
    local timestamp
    timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

    local all_tokens="[]"

    for network_dir in "$ROOT_DIR"/chains/*/; do
        local network
        network=$(basename "$network_dir")

        # Skip non-network directories
        if [ "$network" = "tokenlist.schema.json" ] || [ "$network" = "asset.schema.json" ]; then
            continue
        fi

        local tokenlist="$network_dir/tokenlist.json"
        if [ -f "$tokenlist" ]; then
            local tokens
            tokens=$(jq '.tokens' "$tokenlist" 2>/dev/null || echo "[]")
            all_tokens=$(echo "$all_tokens" "$tokens" | jq -s 'add')
        fi
    done

    local token_count
    token_count=$(echo "$all_tokens" | jq 'length')

    local combined
    combined=$(jq -n \
        --arg timestamp "$timestamp" \
        --argjson tokens "$all_tokens" \
        '{
            name: "Hexis Wallet: All Networks",
            logoURI: "https://raw.githubusercontent.com/fbsobreira/wallet-data/main/logo.png",
            timestamp: $timestamp,
            version: {
                major: 1,
                minor: 0,
                patch: 0
            },
            keywords: ["hexis", "multichain"],
            tokens: $tokens
        }')

    echo "$combined" | jq '.' > "$output_file"
    log_success "Built combined tokenlist ($token_count tokens)"
}

# Main
main() {
    local network="${1:-all}"

    echo "============================================"
    echo "  Wallet Data Build"
    echo "============================================"
    echo ""

    if [ "$network" = "all" ]; then
        for network_dir in "$ROOT_DIR"/chains/*/; do
            local net
            net=$(basename "$network_dir")
            if [ -d "$network_dir/assets" ]; then
                build_tokenlist "$net"
            fi
        done
        build_combined
    else
        build_tokenlist "$network"
    fi

    echo ""
    echo "============================================"
    echo "  Build Complete"
    echo "============================================"
}

main "$@"
