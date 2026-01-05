# Cross-Chain Bridges

Registry of verified cross-chain bridge contracts and protocols.

## Repository Structure

```
bridges/
├── manifest.json           # Index of all bridges
└── bridges.json            # All bridge data
```

## Manifest Schema

**File**: `bridges/manifest.json`

```json
{
  "version": "1.0.0",
  "updated": "2025-01-04T12:00:00Z",
  "statistics": {
    "total_bridges": 15,
    "verified": 12,
    "networks_supported": 8
  }
}
```

## Bridges Schema

**File**: `bridges/bridges.json`

```json
{
  "version": "1.0.0",
  "updated": "2025-01-04T12:00:00Z",
  "bridges": [
    {
      "id": "across-protocol",
      "name": "Across Protocol",
      "description": "Fast and low-cost cross-chain bridge",
      "website": "https://across.to",
      "logo": "https://example.com/across-logo.png",
      "type": "liquidity",
      "status": "active",
      "contracts": {
        "ethereum": {
          "bridge": "0x5c7BCd6E7De5423a257D81B442095A1a6ced35C5",
          "verified": true
        },
        "polygon": {
          "bridge": "0x9295ee1d8C5b022Be115A2AD3c30C72E34e7F096",
          "verified": true
        },
        "arbitrum": {
          "bridge": "0xe35e9842fceaCA96570B734083f4a58e8F7C5f2A",
          "verified": true
        }
      },
      "supported_chains": [
        { "chain_id": 1, "name": "Ethereum" },
        { "chain_id": 137, "name": "Polygon" },
        { "chain_id": 42161, "name": "Arbitrum" },
        { "chain_id": 10, "name": "Optimism" }
      ],
      "supported_tokens": ["ETH", "USDC", "USDT", "WBTC", "DAI"],
      "fees": {
        "type": "dynamic",
        "description": "0.04-0.12% based on route"
      },
      "speed": {
        "typical": "1-5 minutes",
        "description": "Optimistic verification"
      },
      "audit": {
        "audited": true,
        "auditors": ["OpenZeppelin"],
        "reports": ["https://example.com/audit.pdf"]
      },
      "verified": true,
      "risk_level": "low",
      "tags": ["optimistic", "fast", "low-fees"]
    }
  ]
}
```

## Field Reference

### Bridge Object

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `id` | string | Yes | Unique identifier |
| `name` | string | Yes | Bridge name |
| `description` | string | Yes | Brief description |
| `website` | string | Yes | Official website |
| `logo` | string | No | Logo URL |
| `type` | string | Yes | Bridge type |
| `status` | string | Yes | Operational status |
| `contracts` | object | Yes | Contract addresses by chain |
| `supported_chains` | array | Yes | Supported networks |
| `supported_tokens` | array | Yes | Bridgeable tokens |
| `fees` | object | Yes | Fee structure |
| `speed` | object | No | Transfer speed |
| `audit` | object | No | Security audit info |
| `verified` | boolean | Yes | Verification status |
| `risk_level` | string | Yes | Risk assessment |
| `tags` | array | No | Search tags |

### Bridge Types

| Type | Description |
|------|-------------|
| `liquidity` | Liquidity pool based |
| `lock-mint` | Lock on source, mint on destination |
| `native` | Native chain bridge |
| `optimistic` | Optimistic verification |
| `zk` | Zero-knowledge proof based |
| `multisig` | Multi-signature validation |

### Status Values

| Status | Description |
|--------|-------------|
| `active` | Fully operational |
| `paused` | Temporarily paused |
| `deprecated` | No longer recommended |
| `compromised` | Security incident |

### Risk Levels

| Level | Description |
|-------|-------------|
| `low` | Audited, battle-tested, decentralized |
| `medium` | Audited, some centralization |
| `high` | Limited audit, centralized |
| `critical` | Known vulnerabilities |

## Bridge Examples

### Native Bridge (Polygon)

```json
{
  "id": "polygon-bridge",
  "name": "Polygon Bridge",
  "description": "Official Polygon PoS Bridge",
  "website": "https://wallet.polygon.technology/bridge",
  "type": "lock-mint",
  "status": "active",
  "contracts": {
    "ethereum": {
      "bridge": "0xA0c68C638235ee32657e8f720a23ceC1bFc77C77",
      "verified": true
    },
    "polygon": {
      "bridge": "0x0000000000000000000000000000000000001001",
      "verified": true
    }
  },
  "supported_chains": [
    { "chain_id": 1, "name": "Ethereum" },
    { "chain_id": 137, "name": "Polygon" }
  ],
  "speed": {
    "to_polygon": "7-8 minutes",
    "to_ethereum": "~45 minutes (checkpoint)"
  },
  "verified": true,
  "risk_level": "low"
}
```

### Aggregator Bridge

```json
{
  "id": "li-fi",
  "name": "LI.FI",
  "description": "Bridge and DEX aggregator",
  "website": "https://li.fi",
  "type": "aggregator",
  "status": "active",
  "contracts": {
    "ethereum": {
      "diamond": "0x1231DEB6f5749EF6cE6943a275A1D3E7486F4EaE",
      "verified": true
    }
  },
  "supported_chains": [
    { "chain_id": 1, "name": "Ethereum" },
    { "chain_id": 137, "name": "Polygon" },
    { "chain_id": 56, "name": "BSC" },
    { "chain_id": 42161, "name": "Arbitrum" },
    { "chain_id": 10, "name": "Optimism" },
    { "chain_id": 43114, "name": "Avalanche" }
  ],
  "fees": {
    "type": "passthrough",
    "description": "Underlying bridge fees apply"
  },
  "verified": true,
  "risk_level": "low"
}
```

## Security Considerations

### Before Using a Bridge

1. **Check verification status** - Only use `verified: true` bridges
2. **Review audit reports** - Look for recent audits
3. **Check risk level** - Understand the tradeoffs
4. **Verify contract addresses** - Match with official sources

### Common Risks

| Risk | Description |
|------|-------------|
| Smart contract bug | Vulnerability in bridge code |
| Oracle manipulation | Price feed attacks |
| Validator collusion | Centralized validation |
| Liquidity issues | Insufficient exit liquidity |

## Adding a Bridge

```markdown
## Bridge Submission

- Name: MyBridge
- Website: https://mybridge.com
- Type: liquidity

### Contracts
- Ethereum: 0x...
- Polygon: 0x...

### Verification
- Audit report: [link]
- Contract verification: [etherscan links]
- TVL: $X million

### Checklist
- [ ] All contracts verified on explorers
- [ ] Security audit available
- [ ] Active for 3+ months
- [ ] No security incidents
```

## Fetch URLs

```
Base: https://raw.githubusercontent.com/fbsobreira/wallet-data/main/bridges/

manifest.json    → /bridges/manifest.json
All bridges      → /bridges/bridges.json
```
