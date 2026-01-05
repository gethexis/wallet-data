# Staking Validators

Validator information for Proof-of-Stake networks supported by Hexis Wallet.

## Repository Structure

```
validators/
├── manifest.json           # Index of all validator lists
├── klever/
│   └── validators.json
├── ethereum/
│   └── validators.json     # Staking pools/services
└── solana/
    └── validators.json
```

## Manifest Schema

**File**: `validators/manifest.json`

```json
{
  "version": "1.0.0",
  "updated": "2025-01-04T12:00:00Z",
  "networks": {
    "klever": {
      "version": "1.0.0",
      "count": 25,
      "total_staked": "5000000000"
    },
    "ethereum": {
      "version": "1.0.0",
      "count": 10
    }
  }
}
```

## Validators Schema

**File**: `validators/{network}/validators.json`

```json
{
  "network_id": "klever",
  "version": "1.0.0",
  "updated": "2025-01-04T12:00:00Z",
  "validators": [
    {
      "address": "klv1...",
      "name": "Klever Foundation",
      "description": "Official Klever Foundation validator",
      "logo": "https://example.com/logo.png",
      "website": "https://klever.org",
      "commission": 5.0,
      "status": "active",
      "staked": "500000000",
      "delegators": 1250,
      "uptime": 99.9,
      "verified": true,
      "tags": ["foundation", "high-uptime"],
      "contact": {
        "email": "validators@klever.org",
        "twitter": "@klever_io",
        "telegram": "klever_io"
      }
    }
  ]
}
```

## Field Reference

### Validator Object

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `address` | string | Yes | Validator address |
| `name` | string | Yes | Validator name |
| `description` | string | No | Brief description |
| `logo` | string | No | Logo URL |
| `website` | string | No | Official website |
| `commission` | number | Yes | Commission rate (percentage) |
| `status` | string | Yes | `active`, `inactive`, `jailed` |
| `staked` | string | No | Total staked amount (raw units) |
| `delegators` | number | No | Number of delegators |
| `uptime` | number | No | Uptime percentage |
| `verified` | boolean | No | Identity verified |
| `tags` | string[] | No | Categorization tags |
| `contact` | object | No | Contact information |

### Status Values

| Status | Description |
|--------|-------------|
| `active` | Currently validating blocks |
| `inactive` | Not currently validating |
| `jailed` | Penalized for misbehavior |

### Common Tags

| Tag | Description |
|-----|-------------|
| `foundation` | Official project foundation |
| `exchange` | Exchange-operated |
| `high-uptime` | 99%+ uptime |
| `low-commission` | Below average commission |
| `institutional` | Institutional validator |
| `community` | Community-run |

## Network Examples

### Klever Validators

```json
{
  "network_id": "klever",
  "validators": [
    {
      "address": "klv1foundation...",
      "name": "Klever Foundation",
      "commission": 5.0,
      "status": "active",
      "verified": true,
      "tags": ["foundation"]
    },
    {
      "address": "klv1community...",
      "name": "Community Validator",
      "commission": 8.0,
      "status": "active",
      "website": "https://example.com",
      "tags": ["community", "high-uptime"]
    }
  ]
}
```

### Ethereum Staking Pools

For Ethereum, we track staking pools/services rather than individual validators:

```json
{
  "network_id": "ethereum",
  "validators": [
    {
      "address": "0x...",
      "name": "Lido",
      "type": "liquid_staking",
      "description": "Liquid staking protocol",
      "website": "https://lido.fi",
      "fee": 10.0,
      "status": "active",
      "token": {
        "symbol": "stETH",
        "address": "0xae7ab96520DE3A18E5e111B5EaAb095312D7fE84"
      },
      "verified": true,
      "tags": ["liquid-staking", "defi"]
    },
    {
      "address": "0x...",
      "name": "Rocket Pool",
      "type": "liquid_staking",
      "description": "Decentralized staking protocol",
      "website": "https://rocketpool.net",
      "fee": 15.0,
      "status": "active",
      "token": {
        "symbol": "rETH",
        "address": "0xae78736Cd615f374D3085123A210448E74Fc6393"
      },
      "verified": true,
      "tags": ["liquid-staking", "decentralized"]
    }
  ]
}
```

### Solana Validators

```json
{
  "network_id": "solana",
  "validators": [
    {
      "address": "Vote111...",
      "name": "Solana Foundation",
      "commission": 0,
      "status": "active",
      "staked": "5000000000000",
      "verified": true,
      "tags": ["foundation"]
    }
  ]
}
```

## Verification Criteria

Validators marked as `verified: true` should have:

| Criteria | Verification Method |
|----------|---------------------|
| Active on-chain | Block explorer query |
| Identity claimed | Website or social links |
| Accurate commission | On-chain comparison |
| Uptime data | Historical performance |

## Adding Validators

### Self-Submission

Validator operators can submit their own information:

1. Fork the repository
2. Add entry to `validators/{network}/validators.json`
3. Update manifest
4. Submit PR with:
   - Proof of validator ownership
   - Official contact information
   - Website/social links

### Community Submission

Community members can add validators they use:

1. Verify validator is active on-chain
2. Include block explorer link in PR
3. Note: `verified` should be `false` unless operator confirms

### PR Template

```markdown
## Validator Submission

- Network: Klever
- Validator Address: klv1...
- Name: My Validator
- Commission: 5%
- Website: https://example.com

### Verification
- Block explorer: [link]
- Proof of ownership: [signature or tweet]

### Checklist
- [ ] Validator is active on-chain
- [ ] Commission rate is accurate
- [ ] Contact information provided
```

## Fetch URLs

```
Base: https://raw.githubusercontent.com/fbsobreira/wallet-data/main/validators/

manifest.json         → /validators/manifest.json
Klever validators     → /validators/klever/validators.json
Ethereum pools        → /validators/ethereum/validators.json
```
