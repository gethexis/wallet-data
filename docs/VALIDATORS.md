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
      "description": "Klever blockchain validators"
    },
    "ethereum": {
      "version": "1.0.0",
      "description": "Ethereum liquid staking protocols"
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
      "verified": true,
      "tags": ["foundation"]
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
| `type` | string | No | `validator`, `liquid_staking`, `native_staking` |
| `description` | string | No | Brief description |
| `logo` | string | No | Logo URL |
| `website` | string | No | Official website |
| `token` | object | No | LST token info (for liquid staking) |
| `verified` | boolean | No | Identity verified |
| `tags` | string[] | No | Categorization tags |
| `contact` | object | No | Contact information |

**Note**: Dynamic fields like `commission`, `status`, `staked`, `delegators`, and `uptime` are intentionally omitted as they change frequently. These should be fetched from on-chain data at runtime.

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
      "address": "klv1apnq55lqxtlz83ax82pvtdjmegv6xvvlpzeplvwznnql3ld76cpq8q3fmg",
      "name": "KVGermany-II",
      "description": "German validator node",
      "logo": "https://kvgermany.de/wp-content/uploads/2024/03/web.png",
      "website": "https://kvgermany.de",
      "verified": false,
      "tags": ["community"]
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
      "address": "0xae7ab96520DE3A18E5e111B5EaAb095312D7fE84",
      "name": "Lido",
      "type": "liquid_staking",
      "description": "Liquid staking protocol - Stake ETH and receive stETH",
      "website": "https://lido.fi",
      "logo": "https://assets.coingecko.com/coins/images/13442/standard/steth_logo.png",
      "token": {
        "symbol": "stETH",
        "address": "0xae7ab96520DE3A18E5e111B5EaAb095312D7fE84"
      },
      "verified": true,
      "tags": ["liquid-staking", "defi", "audited"]
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
      "address": "J1to1yufRnoWn81KYg1XkTWzmKjnYSnmE2VY8DGUJ9Qv",
      "name": "Jito",
      "type": "liquid_staking",
      "description": "MEV-optimized liquid staking protocol",
      "website": "https://jito.network",
      "token": {
        "symbol": "JitoSOL",
        "address": "J1toso1uCk3RLmjorhTtrVwY9HJ7X8V9yYac6Y7kGCPn"
      },
      "verified": true,
      "tags": ["liquid-staking", "mev"]
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
