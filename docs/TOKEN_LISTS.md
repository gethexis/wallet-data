# Token Lists

Community-maintained token metadata for Hexis Wallet.

**Repository:** https://github.com/fbsobreira/wallet-data

## Repository Structure

```
chains/
├── tokenlist.schema.json       # Token list JSON schema
├── asset.schema.json           # Individual asset JSON schema
├── tokenlist.json              # Master token list (all networks)
├── {network}/                  # One directory per blockchain
│   ├── info/
│   │   ├── info.json           # Blockchain metadata (native token)
│   │   └── logo.png            # Chain logo
│   ├── assets/                 # Token assets (community-contributed)
│   │   └── {address}/
│   │       ├── info.json       # Token metadata
│   │       └── logo.png        # Token logo
│   └── tokenlist.json          # Network-specific token list
```

### Supported Blockchains

| Category | Networks |
|----------|----------|
| **Layer 1** | bitcoin, ethereum, solana, tron, cardano, polkadot, cosmos, avalanche, near, aptos, sui, fantom, hedera, flow, multiversx, klever |
| **EVM L1** | binance-smart-chain, polygon, harmony, moonbeam, astar, chiliz, reef |
| **Layer 2** | arbitrum, optimism, base, polygon-zkevm, rollux, syscoin-nevm |
| **Bitcoin Forks** | litecoin, bitcoin-cash, dogecoin, dash, digibyte |
| **Polkadot/Kusama** | kusama, moonriver, acala, karura, centrifuge, altair, kilt, avail |
| **Cosmos** | celestia, cudos, aura |
| **Other** | stellar, ripple, internet-computer, binance-beacon, syscoin, sdn |

## Quick Start

### Adding a Token

1. Create the asset folder:
   ```
   chains/{network}/assets/{address}/
   ```

2. Add `info.json`:
   ```json
   {
     "name": "Token Name",
     "symbol": "TKN",
     "type": "ERC20",
     "decimals": 18,
     "status": "active",
     "id": "0x...",
     "description": "Brief description",
     "website": "https://example.com",
     "explorer": "https://etherscan.io/token/0x...",
     "tags": ["defi"],
     "links": []
   }
   ```

3. Add `logo.png` (256x256, transparent background)

4. Submit Pull Request

## Blockchain Info Schema

**File**: `chains/{network}/info/info.json`

```json
{
  "name": "Ethereum",
  "symbol": "ETH",
  "type": "native",
  "decimals": 18,
  "status": "active",
  "description": "Open source platform for decentralized applications",
  "website": "https://ethereum.org",
  "explorer": "https://etherscan.io",
  "tags": ["smart-contracts", "staking-native", "evm"],
  "links": [
    {"name": "twitter", "url": "https://x.com/ethereum"},
    {"name": "github", "url": "https://github.com/ethereum"}
  ]
}
```

## Token Asset Schema

**File**: `chains/{network}/assets/{address}/info.json`

```json
{
  "name": "Tether USD",
  "symbol": "USDT",
  "type": "ERC20",
  "decimals": 6,
  "status": "active",
  "id": "0xdAC17F958D2ee523a2206206994597C13D831ec7",
  "description": "Stablecoin pegged to the US dollar",
  "website": "https://tether.to",
  "explorer": "https://etherscan.io/token/0xdAC17F958D2ee523a2206206994597C13D831ec7",
  "tags": ["stablecoin"],
  "links": [
    {"name": "twitter", "url": "https://x.com/Tether_to"},
    {"name": "coingecko", "url": "https://www.coingecko.com/en/coins/tether"}
  ]
}
```

### Required Fields

| Field | Type | Description |
|-------|------|-------------|
| `name` | string | Full token name (max 60 chars) |
| `symbol` | string | Token ticker (max 20 chars) |
| `type` | string | Token standard: `ERC20`, `BEP20`, `TRC20`, `SPL`, `KDA`, `native` |
| `decimals` | number | Decimal places (0-255) |
| `status` | string | `active`, `deprecated`, or `spam` |
| `id` | string | Contract address (must match folder name) |

### Basic Optional Fields

| Field | Type | Description |
|-------|------|-------------|
| `description` | string | Brief description (max 500 chars) |
| `website` | string | Official website URL |
| `explorer` | string | Block explorer link |
| `chain_id` | number | Chain ID for EVM-compatible networks |
| `tags` | array | Categories: `stablecoin`, `wrapped`, `defi`, `gaming`, etc. |
| `links` | array | Social/external links |

### API/RPC Endpoints

The `api` field in `chains/{network}/info/info.json` contains the endpoints for each blockchain, organized by network and type:

```json
"api": {
  "mainnet": {
    "node": ["https://node.example.com", "https://backup-node.example.com"],
    "indexer": ["https://api.example.com"]
  },
  "testnet": {
    "node": ["https://testnet-node.example.com"],
    "indexer": ["https://testnet-api.example.com"]
  }
}
```

#### Endpoint Types

| Type | Purpose | Examples |
|------|---------|----------|
| `node` | Send transactions, basic RPC/gRPC queries, block data | node.mainnet.klever.org, eth.llamarpc.com |
| `indexer` | Transaction history, token balances, rich queries | api.mainnet.klever.org, api.trongrid.io |

### Pricing

| Field | Type | Description |
|-------|------|-------------|
| `coingecko_id` | string | CoinGecko API identifier |
| `coinmarketcap_id` | number | CoinMarketCap ID |
| `chainlink_feed` | string | Chainlink price feed contract address |
| `pegged_to` | object | Peg info: `asset`, `ratio`, `type` (hard/soft/algorithmic) |

### Supply

| Field | Type | Description |
|-------|------|-------------|
| `total` | string | Total supply in raw units |
| `circulating` | string | Circulating supply in raw units |
| `max` | string/null | Maximum supply (null if unlimited) |
| `burnable` | boolean | Has burn mechanism |
| `mintable` | boolean | Can mint new tokens |

### Staking

| Field | Type | Description |
|-------|------|-------------|
| `enabled` | boolean | Whether this token can be staked |
| `type` | string | `native`, `liquid`, `pool`, `farm`, `vault` |
| `native_staking` | boolean | Staked on native blockchain protocol |
| `protocol` | string | Staking protocol name |
| `apy_source` | string | API URL for current APY |
| `rewards_token` | string | Symbol of rewards token |
| `auto_compound` | boolean | Auto-compounds rewards |
| `lock_period` | string/null | Lock period duration |
| `min_stake` | string | Minimum stake amount in raw units |
| `unstake_period` | string | Time required to unstake |
| `staking_url` | string | URL to stake |

### Features (Special Token Behaviors)

| Field | Type | Description |
|-------|------|-------------|
| `rebasing` | boolean | Balance changes automatically (stETH, OHM) |
| `fee_on_transfer` | boolean | Takes fee on each transfer |
| `reflection` | boolean | Auto-distributes to holders |
| `burnable` | boolean | Burns tokens on transfer |
| `pausable` | boolean | Can be paused by owner |
| `blacklistable` | boolean | Can blacklist/freeze addresses (USDC) |
| `wrapped_native` | boolean | Is wrapped native token (WETH, WBNB) |
| `governance` | boolean | Has governance/voting power |

### Contract Details

| Field | Type | Description |
|-------|------|-------------|
| `verified` | boolean | Source code verified on explorer |
| `proxy` | boolean | Is a proxy contract |
| `proxy_type` | string | `transparent`, `uups`, `beacon`, `minimal` |
| `upgradeable` | boolean | Can be upgraded |
| `has_owner` | boolean | Has owner/admin functions |
| `renounced` | boolean | Ownership has been renounced |
| `deployer` | string | Deployer address |
| `deploy_date` | string | Deployment date (YYYY-MM-DD) |

### Security

| Field | Type | Description |
|-------|------|-------------|
| `audited` | boolean | Has been audited |
| `audits` | array | List of audits: `auditor`, `date`, `report` URL |
| `bug_bounty` | string | Bug bounty program URL |
| `risk_level` | string | `low`, `medium`, `high`, `critical` |
| `warnings` | array | Known issues/warnings |

### Cross-Chain

| Field | Type | Description |
|-------|------|-------------|
| `canonical_chain` | number | Chain ID of canonical/original version |
| `bridges` | array | Same token on other chains |

Bridge entry fields: `chain_id`, `chain_name`, `address`, `bridge`, `type` (canonical/bridged/native)

### Trading

| Field | Type | Description |
|-------|------|-------------|
| `tradeable` | boolean | Can be traded |
| `primary_dex` | object | Best DEX: `name`, `pool`, `router` |
| `pairs` | array | Trading pairs (e.g., `["ETH", "USDC"]`) |

### Klever-Specific (KDA Tokens)

For KDA tokens on Klever blockchain:

| Field | Type | Description |
|-------|------|-------------|
| `asset_type` | string | `Fungible`, `NonFungible`, `SemiFungible` |
| `precision` | number | Asset precision |
| `owner` | string | Asset owner address |
| `royalties` | object | `transfer` and `market` royalty percentages |
| `properties` | object | `can_freeze`, `can_wipe`, `can_pause`, `can_mint`, `can_burn`, `can_change_owner` |
| `staking` | object | KDA staking: `enabled`, `apr`, `min_stake`, `claim_type` |

## Tags Reference

### Token Type Tags
| Tag | Description |
|-----|-------------|
| `stablecoin` | Pegged to fiat/asset |
| `wrapped` | Wrapped version of another asset |
| `governance` | Voting/governance token |
| `utility` | Platform utility token |
| `meme` | Meme/community token |

### Feature Tags
| Tag | Description |
|-----|-------------|
| `staking` | Can be staked |
| `liquid-staking` | Liquid staking derivative |
| `defi` | DeFi protocol token |
| `gaming` | Gaming token |
| `nft` | NFT-related token |
| `metaverse` | Metaverse token |

### Blockchain Tags
| Tag | Description |
|-----|-------------|
| `layer-1` | Layer 1 blockchain |
| `layer-0` | Layer 0 protocol |
| `parachain` | Polkadot/Kusama parachain |
| `evm` | EVM-compatible |
| `smart-contracts` | Supports smart contracts |
| `staking-native` | Has native staking |

### Risk Tags
| Tag | Description |
|-----|-------------|
| `rebasing` | Rebasing token (special display) |
| `fee-on-transfer` | Has transfer fees |
| `blacklistable` | Can freeze addresses |
| `experimental` | New/experimental |

## Token List (Uniswap Standard)

**File**: `chains/{network}/tokenlist.json`

Follows the [Uniswap Token List](https://tokenlists.org/) standard:

```json
{
  "name": "Hexis Wallet: Ethereum",
  "logoURI": "https://...",
  "timestamp": "2025-01-04T00:00:00Z",
  "version": {
    "major": 1,
    "minor": 0,
    "patch": 0
  },
  "keywords": ["hexis", "ethereum"],
  "tokens": [
    {
      "chainId": 1,
      "address": "0xdAC17F958D2ee523a2206206994597C13D831ec7",
      "name": "Tether USD",
      "symbol": "USDT",
      "decimals": 6,
      "logoURI": "https://...",
      "tags": ["stablecoin"],
      "extensions": {
        "coingeckoId": "tether",
        "website": "https://tether.to"
      }
    }
  ]
}
```

## Logo Requirements

| Specification | Requirement |
|---------------|-------------|
| Format | PNG (lowercase `.png`) |
| Dimensions | 256x256 pixels |
| Background | Transparent preferred |
| Max file size | 100KB |
| File name | `logo.png` (exact) |

## Network-Specific Notes

### Klever (KDA Tokens)

- `id` = Asset ID (e.g., `KUNAI-18TK`, `DVK-34ZH`)
- Folder name = Asset ID
- Decimals vary per asset

### Tron (TRC-20)

- `id` = Base58 contract address (e.g., `TR7N...`)
- Common decimals: 6 (USDT, USDC), 18 (others)

### EVM Chains (Ethereum, Polygon, BSC)

- `id` = Checksummed hex address (e.g., `0xdAC17F...`)
- Include checksum format (mixed case)

### Solana (SPL Tokens)

- `id` = Token mint address (Base58)
- Typical decimals: 6-9

## Fetch URLs

Raw GitHub URLs:

```
Base: https://raw.githubusercontent.com/fbsobreira/wallet-data/main/chains/

# Master token list (all networks)
/chains/tokenlist.json

# Blockchain info
/chains/ethereum/info/info.json
/chains/klever/info/info.json

# Network token lists (Uniswap standard)
/chains/ethereum/tokenlist.json
/chains/klever/tokenlist.json

# Individual tokens
/chains/ethereum/assets/0xdAC17F958D2ee523a2206206994597C13D831ec7/info.json
/chains/klever/assets/KUNAI-18TK/info.json

# Logos
/chains/ethereum/assets/0xdAC17F958D2ee523a2206206994597C13D831ec7/logo.png
/chains/klever/assets/KUNAI-18TK/logo.png
```

## Building Token Lists

Token lists are auto-generated from assets:

```bash
# Build all token lists
make build

# Build specific network
make build-ethereum

# Or use script directly
./scripts/build.sh all
./scripts/build.sh ethereum
```

## Validation

```bash
# Validate all data
make check

# Validate chains (blockchain info + tokens)
make check-chains

# Validate single token
make validate-token NETWORK=ethereum ADDRESS=0x...
```

## Contributing

See [SUBMISSION_CRITERIA.md](SUBMISSION_CRITERIA.md) for detailed requirements.

1. Fork the repository
2. Create asset folder: `chains/{network}/assets/{address}/`
3. Add `info.json` following the schema
4. Add `logo.png` (256x256 PNG)
5. Run `make check` to validate
6. Submit Pull Request
