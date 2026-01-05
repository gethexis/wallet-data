#!/bin/bash
# Wallet Data Validation Script
# Usage: ./scripts/validate.sh [category]
# Categories: all, chains, validators, dapps, scams, bridges, nfts, contacts

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

ERRORS=0
WARNINGS=0

log_error() {
    echo -e "${RED}ERROR:${NC} $1"
    ((ERRORS++))
}

log_warning() {
    echo -e "${YELLOW}WARNING:${NC} $1"
    ((WARNINGS++))
}

log_success() {
    echo -e "${GREEN}OK:${NC} $1"
}

log_info() {
    echo -e "INFO: $1"
}

# Validate JSON syntax
validate_json() {
    local file="$1"
    if ! jq empty "$file" 2>/dev/null; then
        log_error "Invalid JSON: $file"
        return 1
    fi
    return 0
}

# Validate required fields in token info.json
validate_token_info() {
    local file="$1"
    local required_fields=("name" "symbol" "type" "decimals" "status" "id")

    for field in "${required_fields[@]}"; do
        if ! jq -e ".$field" "$file" > /dev/null 2>&1; then
            log_error "Missing required field '$field' in $file"
        fi
    done

    # Validate id matches folder name
    local folder_name
    folder_name=$(basename "$(dirname "$file")")
    local id
    id=$(jq -r '.id' "$file" 2>/dev/null)

    if [ "$folder_name" != "$id" ]; then
        log_error "Asset id '$id' does not match folder name '$folder_name' in $file"
    fi

    # Validate decimals is a number between 0-255
    local decimals
    decimals=$(jq -r '.decimals' "$file" 2>/dev/null)
    if ! [[ "$decimals" =~ ^[0-9]+$ ]] || [ "$decimals" -lt 0 ] || [ "$decimals" -gt 255 ]; then
        log_error "Invalid decimals '$decimals' in $file (must be 0-255)"
    fi

    # Validate status
    local status
    status=$(jq -r '.status' "$file" 2>/dev/null)
    if [[ ! "$status" =~ ^(active|abandoned|spam)$ ]]; then
        log_error "Invalid status '$status' in $file (must be active, abandoned, or spam)"
    fi
}

# Validate blockchain info.json
validate_blockchain_info() {
    local file="$1"
    local required_fields=("name" "symbol" "type" "decimals" "status")

    for field in "${required_fields[@]}"; do
        if ! jq -e ".$field" "$file" > /dev/null 2>&1; then
            log_error "Missing required field '$field' in $file"
        fi
    done
}

# Validate tokenlist.json
validate_tokenlist() {
    local file="$1"
    local required_fields=("name" "timestamp" "version" "tokens")

    for field in "${required_fields[@]}"; do
        if ! jq -e ".$field" "$file" > /dev/null 2>&1; then
            log_error "Missing required field '$field' in $file"
        fi
    done

    # Validate version structure
    if ! jq -e '.version.major' "$file" > /dev/null 2>&1; then
        log_error "Missing version.major in $file"
    fi

    # Validate each token in the list
    local token_count
    token_count=$(jq '.tokens | length' "$file" 2>/dev/null)
    log_info "Found $token_count tokens in $file"

    for i in $(seq 0 $((token_count - 1))); do
        for field in address name symbol decimals; do
            if ! jq -e ".tokens[$i].$field" "$file" > /dev/null 2>&1; then
                log_error "Token $i missing required field '$field' in $file"
            fi
        done
    done
}

# Validate logo file
validate_logo() {
    local file="$1"

    if [ ! -f "$file" ]; then
        log_warning "Missing logo: $file"
        return 0
    fi

    # Check file extension
    if [[ ! "$file" =~ \.png$ ]]; then
        log_error "Logo must be PNG format: $file"
        return 1
    fi

    # Check if file is actually a PNG (not JPEG with .png extension)
    if command -v file &> /dev/null; then
        local file_type
        file_type=$(file -b "$file" | cut -d' ' -f1)
        if [ "$file_type" != "PNG" ]; then
            log_error "$file is not a valid PNG file (detected: $file_type)"
            return 1
        fi
    fi

    # Check file size (max 100KB)
    local size
    size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null)
    if [ "$size" -gt 102400 ]; then
        log_warning "Logo exceeds 100KB: $file ($size bytes)"
    fi

    # Check dimensions if 'file' command is available
    if command -v file &> /dev/null; then
        local dimensions
        dimensions=$(file "$file" | grep -oE '[0-9]+ x [0-9]+' | head -1)
        if [ -n "$dimensions" ]; then
            local width height
            width=$(echo "$dimensions" | cut -d' ' -f1)
            height=$(echo "$dimensions" | cut -d' ' -f3)
            if [ "$width" != "256" ] || [ "$height" != "256" ]; then
                log_warning "Logo should be 256x256, found ${width}x${height}: $file"
            fi
        fi
    fi

    return 0
}

# Validate EVM checksum address
validate_evm_address() {
    local address="$1"
    local file="$2"

    # Basic format check
    if [[ ! "$address" =~ ^0x[a-fA-F0-9]{40}$ ]]; then
        log_error "Invalid EVM address format '$address' in $file"
        return 1
    fi

    # Check if it has mixed case (indicates checksum format)
    if [[ "$address" =~ ^0x[a-f0-9]{40}$ ]] || [[ "$address" =~ ^0x[A-F0-9]{40}$ ]]; then
        log_warning "Address should use checksum format: $address in $file"
    fi

    return 0
}

# Validate chains directory (blockchain info, tokens, tokenlists)
validate_chains() {
    log_info "Validating chains..."

    # Validate blockchain info files
    for info_file in "$ROOT_DIR"/chains/*/info/info.json; do
        if [ -f "$info_file" ]; then
            if validate_json "$info_file"; then
                validate_blockchain_info "$info_file"
                log_success "$info_file"
            fi
        fi
    done

    # Validate token assets
    for info_file in "$ROOT_DIR"/chains/*/assets/*/info.json; do
        if [ -f "$info_file" ]; then
            if validate_json "$info_file"; then
                validate_token_info "$info_file"

                # Get parent directories
                local asset_dir
                asset_dir=$(dirname "$info_file")
                local network_dir
                network_dir=$(dirname "$(dirname "$asset_dir")")
                local network
                network=$(basename "$network_dir")

                # Validate EVM addresses (all EVM-compatible chains)
                if [[ "$network" =~ ^(ethereum|polygon|polygon-zkevm|binance-smart-chain|arbitrum|optimism|base|avalanche|fantom|moonbeam|moonriver|harmony|heco|rollux|syscoin-nevm|chiliz)$ ]]; then
                    local address
                    address=$(basename "$asset_dir")
                    validate_evm_address "$address" "$info_file"
                fi

                # Check for logo
                validate_logo "$asset_dir/logo.png"

                log_success "$info_file"
            fi
        fi
    done

    # Validate tokenlist.json files
    for tokenlist in "$ROOT_DIR"/chains/*/tokenlist.json; do
        if [ -f "$tokenlist" ]; then
            if validate_json "$tokenlist"; then
                validate_tokenlist "$tokenlist"
                log_success "$tokenlist"
            fi
        fi
    done
}

# Validate all JSON files in a directory
validate_directory() {
    local dir="$1"
    local name="$2"

    log_info "Validating $name..."

    for json_file in "$dir"/**/*.json; do
        if [ -f "$json_file" ]; then
            if validate_json "$json_file"; then
                log_success "$json_file"
            fi
        fi
    done
}

# Main validation
main() {
    local category="${1:-all}"

    echo "============================================"
    echo "  Wallet Data Validation"
    echo "============================================"
    echo ""

    case "$category" in
        all)
            validate_chains
            validate_directory "$ROOT_DIR/validators" "validators"
            validate_directory "$ROOT_DIR/dapps" "dapps"
            validate_directory "$ROOT_DIR/scams" "scams"
            validate_directory "$ROOT_DIR/bridges" "bridges"
            validate_directory "$ROOT_DIR/nfts" "nfts"
            validate_directory "$ROOT_DIR/contacts" "contacts"
            ;;
        chains)
            validate_chains
            ;;
        validators|dapps|scams|bridges|nfts|contacts)
            validate_directory "$ROOT_DIR/$category" "$category"
            ;;
        *)
            echo "Unknown category: $category"
            echo "Usage: $0 [all|chains|validators|dapps|scams|bridges|nfts|contacts]"
            exit 1
            ;;
    esac

    echo ""
    echo "============================================"
    echo "  Validation Complete"
    echo "============================================"
    echo ""
    echo -e "Errors:   ${RED}$ERRORS${NC}"
    echo -e "Warnings: ${YELLOW}$WARNINGS${NC}"
    echo ""

    if [ $ERRORS -gt 0 ]; then
        exit 1
    fi
    exit 0
}

main "$@"
