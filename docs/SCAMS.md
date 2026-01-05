# Scam Blocklist

Community-maintained blocklist of known scam addresses, phishing domains, and malicious contracts.

**Important**: This data helps protect users but should be used as one layer of defense. Always verify transactions independently.

## Repository Structure

```
scams/
├── manifest.json           # Index and statistics
├── addresses/
│   ├── klever.json
│   ├── tron.json
│   ├── ethereum.json
│   └── multichain.json
├── domains/
│   └── phishing.json
└── contracts/
    └── malicious.json
```

## Manifest Schema

**File**: `scams/manifest.json`

```json
{
  "version": "1.0.0",
  "updated": "2025-01-04T12:00:00Z",
  "statistics": {
    "total_addresses": 1500,
    "total_domains": 850,
    "total_contracts": 200,
    "reports_30d": 45
  },
  "categories": [
    "phishing",
    "rugpull",
    "honeypot",
    "fake-token",
    "drainer",
    "scam-airdrop",
    "impersonation"
  ]
}
```

## Scam Address Schema

**File**: `scams/addresses/{network}.json`

```json
{
  "network_id": "ethereum",
  "version": "1.0.0",
  "updated": "2025-01-04T12:00:00Z",
  "addresses": [
    {
      "address": "0x1234567890abcdef1234567890abcdef12345678",
      "type": "drainer",
      "severity": "critical",
      "description": "Wallet drainer contract",
      "first_reported": "2025-01-01T00:00:00Z",
      "reports": 25,
      "evidence": [
        "https://twitter.com/scamreport/status/123",
        "https://etherscan.io/address/0x..."
      ],
      "labels": ["drainer", "active"],
      "verified": true
    }
  ]
}
```

## Phishing Domain Schema

**File**: `scams/domains/phishing.json`

```json
{
  "version": "1.0.0",
  "updated": "2025-01-04T12:00:00Z",
  "domains": [
    {
      "domain": "uniswap-airdrop.com",
      "type": "phishing",
      "impersonates": "Uniswap",
      "severity": "critical",
      "first_reported": "2025-01-01T00:00:00Z",
      "status": "active",
      "evidence": ["https://urlscan.io/result/..."],
      "verified": true
    }
  ]
}
```

## Malicious Contract Schema

**File**: `scams/contracts/malicious.json`

```json
{
  "version": "1.0.0",
  "updated": "2025-01-04T12:00:00Z",
  "contracts": [
    {
      "address": "0x...",
      "network": "ethereum",
      "type": "honeypot",
      "name": "Fake USDT",
      "description": "Cannot sell after buying",
      "severity": "high",
      "first_reported": "2025-01-01T00:00:00Z",
      "technical_details": {
        "issue": "transfer() always reverts for non-owner",
        "code_snippet": "require(msg.sender == owner)"
      },
      "verified": true
    }
  ]
}
```

## Field Reference

### Scam Types

| Type | Description |
|------|-------------|
| `phishing` | Fake websites stealing credentials/keys |
| `rugpull` | Project abandoned with user funds |
| `honeypot` | Token cannot be sold |
| `fake-token` | Impersonating legitimate token |
| `drainer` | Contract drains wallet on approval |
| `scam-airdrop` | Fake airdrop requiring payment |
| `impersonation` | Pretending to be legitimate entity |
| `ponzi` | Ponzi/pyramid scheme |

### Severity Levels

| Severity | Description | Action |
|----------|-------------|--------|
| `critical` | Active threat, immediate harm | Block all interaction |
| `high` | Confirmed scam | Warn before interaction |
| `medium` | Suspicious activity | Display warning |
| `low` | Unverified report | Monitor |

### Status Values

| Status | Description |
|--------|-------------|
| `active` | Currently operating |
| `inactive` | No longer active |
| `resolved` | Issue has been addressed |

## Reporting a Scam

### Via Pull Request

1. Fork the repository
2. Add to appropriate file in `scams/`
3. Submit PR with evidence

```markdown
## Scam Report

### Details
- Type: phishing
- Target: ethereum
- Address/Domain: 0x... or example.com

### Evidence
- [ ] Screenshot of scam
- [ ] Block explorer link
- [ ] Community reports (Twitter, Discord)
- [ ] Technical analysis (if contract)

### Impact
- Estimated victims: ~50
- Estimated loss: $10,000

### Additional Notes
Description of how the scam operates...
```

### Via GitHub Issue

For quick reports, open an issue with the "Scam Report" template.

## Verification Process

1. **Initial report** - Added as `verified: false`
2. **Community review** - Multiple confirmations
3. **Technical analysis** - Contract/domain analysis
4. **Verification** - Set to `verified: true`

### Auto-verification triggers

- 5+ independent reports
- Technical proof (honeypot detection)
- Known scam pattern match
- Impersonation of verified project

## Usage Guidelines

### Wallet Integration

```javascript
// Example: Check address before transaction
async function isScamAddress(address, network) {
  const response = await fetch(
    `https://raw.githubusercontent.com/fbsobreira/wallet-data/main/scams/addresses/${network}.json`
  );
  const data = await response.json();
  return data.addresses.some(s =>
    s.address.toLowerCase() === address.toLowerCase()
  );
}
```

### Warning Display

| Severity | Recommended Action |
|----------|-------------------|
| `critical` | Block transaction, require override |
| `high` | Show prominent warning |
| `medium` | Show informational warning |
| `low` | Log for monitoring |

## Data Sources

We aggregate reports from:

- Community submissions
- On-chain analysis
- Social media monitoring
- Security researcher reports
- Block explorer flags

## Privacy & Legal

- Only public blockchain addresses are listed
- No personal identifying information
- Removal requests considered with evidence
- Data provided as-is, no liability assumed

## Fetch URLs

```
Base: https://raw.githubusercontent.com/fbsobreira/wallet-data/main/scams/

manifest.json           → /scams/manifest.json
Ethereum addresses      → /scams/addresses/ethereum.json
Phishing domains        → /scams/domains/phishing.json
Malicious contracts     → /scams/contracts/malicious.json
```
