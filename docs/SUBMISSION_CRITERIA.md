# Token Submission Criteria

Requirements for submitting tokens to the Hexis Wallet token registry.

## Overview

We maintain high standards for token listings to protect users from scams and ensure data quality. This document outlines the requirements for token submissions.

## Minimum Requirements

All token submissions must meet these baseline criteria:

### Token Requirements

| Requirement | Threshold | Verification |
|-------------|-----------|--------------|
| Contract Verified | Required | Block explorer |
| Token Age | 30+ days | Block timestamp |
| Holders | 500+ | On-chain query |
| Transactions | 1,000+ | Explorer stats |
| Active Status | Required | Recent activity |

### Project Requirements

| Requirement | Description |
|-------------|-------------|
| Website | Active, professional website |
| Social Presence | At least 1 active social channel |
| Documentation | Basic token/project description |
| No Scam Indicators | Not flagged on scam databases |

## Submission Process

### 1. Prepare Your Files

Create a folder structure:

```
chains/{network}/assets/{address}/
├── info.json    # Required: Token metadata
└── logo.png     # Required: Token logo
```

### 2. Create info.json

```json
{
  "name": "Your Token Name",
  "symbol": "TKN",
  "type": "ERC20",
  "decimals": 18,
  "status": "active",
  "id": "0xYourTokenAddress",
  "description": "Brief description of your token (max 500 chars)",
  "website": "https://yourproject.com",
  "explorer": "https://etherscan.io/token/0x...",
  "tags": ["defi"],
  "links": [
    {
      "name": "twitter",
      "url": "https://twitter.com/yourproject"
    },
    {
      "name": "coingecko",
      "url": "https://www.coingecko.com/en/coins/your-token"
    }
  ]
}
```

### 3. Prepare Logo

Logo requirements:

| Specification | Requirement |
|---------------|-------------|
| Format | PNG only (lowercase `.png`) |
| Dimensions | 256x256 pixels |
| Background | Transparent preferred |
| File size | Max 100KB |
| File name | Must be `logo.png` |

### 4. Submit Pull Request

1. Fork the repository
2. Create a branch: `add-token-{symbol}`
3. Add your files to the correct location
4. Submit PR with the following template

## PR Template

```markdown
## Token Submission

### Token Details
- **Name**: [Token Name]
- **Symbol**: [SYMBOL]
- **Network**: [ethereum/polygon/bsc/tron/klever/solana]
- **Contract**: [Address]
- **Decimals**: [Number]

### Verification Links
- [ ] Block Explorer: [Link to verified contract]
- [ ] Website: [Official website URL]
- [ ] CoinGecko/CMC: [Link if listed]

### Requirements Checklist
- [ ] Contract verified on block explorer
- [ ] Token is 30+ days old
- [ ] 500+ holders
- [ ] 1,000+ transactions
- [ ] Logo is 256x256 PNG
- [ ] Logo is under 100KB
- [ ] info.json follows schema
- [ ] Not flagged as scam

### Additional Information
[Any other relevant details about the project]
```

## Verification Levels

### Standard Listing

Meets minimum requirements:
- Contract verified
- Basic holder/transaction count
- Active project

### Verified Badge

Higher tier with additional verification:
- 10,000+ holders
- 50,000+ transactions
- Security audit from recognized firm
- CoinGecko/CoinMarketCap listing
- Active development (GitHub activity)
- Strong community presence

## Logo Guidelines

### Design Requirements

1. **Clarity**: Logo should be clear at 256x256
2. **Branding**: Use official project branding
3. **Background**: Transparent background preferred
4. **Format**: PNG format only
5. **Quality**: No pixelation or compression artifacts

### Examples

**Good logos:**
- Clear, centered design
- Transparent background
- Proper resolution

**Bad logos (will be rejected):**
- Blurry or pixelated
- Wrong dimensions
- Non-PNG format
- Too complex for small size
- Contains offensive content

## Address Format

### EVM Chains (Ethereum, Polygon, BSC)

- Use checksummed addresses
- Format: `0x` + 40 hex characters
- Verify checksum on Etherscan

**Example:**
```
✓ 0xdAC17F958D2ee523a2206206994597C13D831ec7  (checksummed)
✗ 0xdac17f958d2ee523a2206206994597c13d831ec7  (all lowercase)
```

### Tron (TRC-20)

- Use Base58 address format
- Starts with `T`

### Klever (KDA)

- Use asset ID
- Example: `KUNAI-18TK`, `DVK-34ZH`

### Solana (SPL)

- Use token mint address
- Base58 format

## Rejection Reasons

Submissions may be rejected for:

| Reason | Description |
|--------|-------------|
| Insufficient data | Missing required fields |
| Low activity | Below minimum thresholds |
| Scam indicators | Flagged on scam databases |
| Poor logo | Doesn't meet requirements |
| Duplicate | Token already listed |
| Invalid format | Schema violations |
| Unverified contract | Contract not verified on explorer |

## Fast-Track Submissions

The following types of tokens may bypass some requirements:

1. **Major stablecoins**: USDT, USDC, DAI, etc.
2. **Wrapped tokens**: Official wrapped versions
3. **Exchange tokens**: Major exchange native tokens
4. **Governance tokens**: Major protocol governance tokens

## Appeals Process

If your submission is rejected:

1. Review the rejection reason
2. Address the issues mentioned
3. Resubmit with a new PR
4. Reference the original PR number

## Contact

For questions about submissions:
- Open a GitHub Discussion
- Tag maintainers in your PR

## Updates

To update existing token information:
1. Edit the existing `info.json`
2. Update logo if needed
3. Submit PR with changes
4. Provide reason for update
