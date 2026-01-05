# Verified dApps

Registry of verified decentralized applications for Hexis Wallet browser integration.

## Repository Structure

```
dapps/
├── manifest.json           # Index of all dApp lists
├── klever/
│   └── dapps.json
├── tron/
│   └── dapps.json
├── ethereum/
│   └── dapps.json
├── polygon/
│   └── dapps.json
├── bsc/
│   └── dapps.json
└── multichain/
    └── dapps.json          # Cross-chain dApps
```

## Manifest Schema

**File**: `dapps/manifest.json`

```json
{
  "version": "1.0.0",
  "updated": "2025-01-04T12:00:00Z",
  "networks": {
    "ethereum": {
      "version": "1.0.0",
      "count": 50
    },
    "multichain": {
      "version": "1.0.0",
      "count": 20
    }
  },
  "categories": [
    "defi",
    "nft",
    "gaming",
    "social",
    "exchange",
    "bridge",
    "dao",
    "utility"
  ]
}
```

## dApps Schema

**File**: `dapps/{network}/dapps.json`

```json
{
  "network_id": "ethereum",
  "version": "1.0.0",
  "updated": "2025-01-04T12:00:00Z",
  "dapps": [
    {
      "id": "uniswap",
      "name": "Uniswap",
      "description": "Decentralized exchange protocol",
      "url": "https://app.uniswap.org",
      "logo": "https://example.com/uniswap-logo.png",
      "category": "defi",
      "subcategory": "dex",
      "contracts": [
        {
          "name": "Router V3",
          "address": "0xE592427A0AEce92De3Edee1F18E0157C05861564"
        }
      ],
      "wallet_connect": {
        "supported": true,
        "version": 2
      },
      "audit": {
        "audited": true,
        "auditors": ["Trail of Bits", "Certik"],
        "reports": ["https://example.com/audit.pdf"]
      },
      "status": "active",
      "verified": true,
      "featured": true,
      "tags": ["swap", "liquidity", "amm"],
      "social": {
        "twitter": "https://x.com/Uniswap",
        "discord": "https://discord.gg/uniswap",
        "github": "https://github.com/Uniswap"
      }
    }
  ]
}
```

## Field Reference

### dApp Object

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `id` | string | Yes | Unique identifier (lowercase, hyphenated) |
| `name` | string | Yes | Display name |
| `description` | string | Yes | Brief description |
| `url` | string | Yes | Official dApp URL |
| `logo` | string | No | Logo URL (128x128 PNG) |
| `category` | string | Yes | Primary category |
| `subcategory` | string | No | More specific category |
| `contracts` | array | No | Associated contract addresses |
| `wallet_connect` | object | No | WalletConnect support |
| `audit` | object | No | Security audit info |
| `status` | string | Yes | `active`, `deprecated`, `warning` |
| `verified` | boolean | Yes | Verified by maintainers |
| `featured` | boolean | No | Featured in wallet |
| `tags` | string[] | No | Search tags |
| `social` | object | No | Social links |

### Categories

| Category | Description | Examples |
|----------|-------------|----------|
| `defi` | DeFi protocols | Uniswap, Aave, Compound |
| `nft` | NFT marketplaces | OpenSea, Blur, Magic Eden |
| `gaming` | Blockchain games | Axie Infinity, Gods Unchained |
| `social` | Social platforms | Lens, Farcaster |
| `exchange` | DEX/CEX interfaces | 1inch, Matcha |
| `bridge` | Cross-chain bridges | Across, Stargate |
| `dao` | Governance platforms | Snapshot, Tally |
| `utility` | Tools & utilities | Etherscan, DeBank |

### Subcategories

| Parent | Subcategory | Description |
|--------|-------------|-------------|
| defi | `dex` | Decentralized exchanges |
| defi | `lending` | Lending protocols |
| defi | `staking` | Staking platforms |
| defi | `yield` | Yield aggregators |
| nft | `marketplace` | NFT trading |
| nft | `launchpad` | NFT minting |
| gaming | `play-to-earn` | P2E games |
| gaming | `metaverse` | Virtual worlds |

### Status Values

| Status | Description |
|--------|-------------|
| `active` | Working and maintained |
| `deprecated` | No longer maintained |
| `warning` | Use with caution |

## Network Examples

### Ethereum dApps

```json
{
  "network_id": "ethereum",
  "dapps": [
    {
      "id": "aave-v3",
      "name": "Aave V3",
      "description": "Decentralized lending protocol",
      "url": "https://app.aave.com",
      "category": "defi",
      "subcategory": "lending",
      "contracts": [
        {
          "name": "Pool",
          "address": "0x87870Bca3F3fD6335C3F4ce8392D69350B4fA4E2"
        }
      ],
      "audit": {
        "audited": true,
        "auditors": ["Certik", "SigmaPrime"]
      },
      "status": "active",
      "verified": true,
      "tags": ["lending", "borrowing", "flash-loans"]
    }
  ]
}
```

### Klever dApps

```json
{
  "network_id": "klever",
  "dapps": [
    {
      "id": "klever-swap",
      "name": "Klever Swap",
      "description": "Native DEX for KDA tokens",
      "url": "https://kleverscan.org/swap",
      "category": "defi",
      "subcategory": "dex",
      "status": "active",
      "verified": true,
      "tags": ["swap", "kda"]
    }
  ]
}
```

### Multichain dApps

```json
{
  "network_id": "multichain",
  "dapps": [
    {
      "id": "1inch",
      "name": "1inch",
      "description": "DEX aggregator",
      "url": "https://app.1inch.io",
      "category": "defi",
      "subcategory": "dex",
      "supported_chains": [1, 137, 56, 42161, 10],
      "status": "active",
      "verified": true,
      "featured": true
    }
  ]
}
```

## Verification Criteria

| Level | Requirements |
|-------|--------------|
| `verified: true` | Official URL, active project, no security issues |
| `featured: true` | Verified + popular + audited |

### Red Flags (auto-reject)

- No verifiable team
- Copied/forked contracts without audit
- Excessive permissions requested
- History of exploits (unless fixed)
- Phishing indicators

## Adding a dApp

1. Fork the repository
2. Add entry to `dapps/{network}/dapps.json`
3. Update manifest
4. Submit PR with:

```markdown
## dApp Submission

- Name: MyDApp
- URL: https://mydapp.com
- Category: defi
- Network: ethereum

### Verification
- Official website: https://mydapp.com
- Contract on Etherscan: [link]
- Audit report: [link] (optional but preferred)

### Checklist
- [ ] URL is official (not a fork/clone)
- [ ] No known security issues
- [ ] Active and maintained
- [ ] Contracts verified on explorer
```

## WalletConnect Integration

dApps with WalletConnect support are prioritized:

```json
{
  "wallet_connect": {
    "supported": true,
    "version": 2,
    "project_id": "abc123..."
  }
}
```

## Fetch URLs

```
Base: https://raw.githubusercontent.com/fbsobreira/wallet-data/main/dapps/

manifest.json      → /dapps/manifest.json
Ethereum dApps     → /dapps/ethereum/dapps.json
Multichain dApps   → /dapps/multichain/dapps.json
```
