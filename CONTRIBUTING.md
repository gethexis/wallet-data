# Contributing to Wallet Data

Thank you for your interest in contributing to Wallet Data! This repository powers the Hexis Wallet with community-maintained blockchain data.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Contribution Types](#contribution-types)
- [Submission Guidelines](#submission-guidelines)
- [Pull Request Process](#pull-request-process)
- [Data Schemas](#data-schemas)
- [Verification Requirements](#verification-requirements)

## Code of Conduct

- Be respectful and constructive
- Provide accurate, verifiable information
- Do not submit malicious or misleading data
- Help maintain data quality through reviews

## Getting Started

1. **Fork** this repository
2. **Clone** your fork locally
3. **Create** a feature branch from `main`
4. **Make** your changes following our schemas
5. **Test** your JSON is valid
6. **Submit** a Pull Request

### Prerequisites

- Basic understanding of JSON format
- Familiarity with the blockchain network you're contributing to
- Verification sources for your submission

## Contribution Types

### Adding Tokens

**Location**: `chains/{network}/assets/{address}/`

Required information:
- Contract/asset address
- Symbol and name
- Decimals
- Verification link (block explorer)

See [TOKEN_LISTS.md](docs/TOKEN_LISTS.md) for full schema.

### Reporting Scams

**File**: `scams/addresses.json` or `scams/domains.json`

Required information:
- Address or domain
- Type of scam
- Evidence links
- Date reported

See [SCAMS.md](docs/SCAMS.md) for full schema.

### Adding Validators

**File**: `validators/{network}/validators.json`

Required information:
- Validator address
- Name and description
- Commission rate
- Status

See [VALIDATORS.md](docs/VALIDATORS.md) for full schema.

### Adding dApps

**File**: `dapps/{network}/dapps.json`

Required information:
- dApp name and URL
- Category
- Contract addresses (if applicable)
- Security audit (if available)

See [DAPPS.md](docs/DAPPS.md) for full schema.

## Submission Guidelines

### JSON Formatting

- Use 2-space indentation
- No trailing commas
- UTF-8 encoding
- Validate JSON before submitting

```bash
# Validate JSON
cat chains/klever/info/info.json | jq .
```

### Naming Conventions

- Network directories: lowercase (`klever`, `ethereum`, `tron`)
- File names: lowercase with hyphens (`info.json`, `tokenlist.json`)
- Asset symbols: UPPERCASE (`USDT`, `KLV`)

### Version Updates

When modifying data files, update the relevant manifest:

```json
{
  "version": "1.0.1",  // Increment patch for additions
  "updated": "2025-01-04T12:00:00Z"  // Current timestamp
}
```

Version increment guide:
- **Patch** (1.0.X): Adding new entries, fixing typos
- **Minor** (1.X.0): New categories, schema additions
- **Major** (X.0.0): Breaking schema changes

## Pull Request Process

### PR Title Format

```
[category] Brief description

Examples:
[tokens] Add KUNAI-18TK token to Klever list
[scams] Report phishing domain example.com
[chains] Add new blockchain support
[validators] Update Klever validator commission rates
```

### PR Description Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] New data entry
- [ ] Data correction
- [ ] Schema update
- [ ] Documentation

## Verification
- Link to block explorer:
- Official project link:
- Additional evidence:

## Checklist
- [ ] JSON is valid
- [ ] Follows schema format
- [ ] Manifest version updated
- [ ] Verification links provided
```

### Review Process

1. **Automated checks**: JSON validation, schema compliance
2. **Community review**: Data accuracy verification
3. **Maintainer approval**: Final merge decision

## Data Schemas

### Common Fields

| Field | Type | Description |
|-------|------|-------------|
| `address` | string | On-chain identifier |
| `name` | string | Human-readable name |
| `verified` | boolean | Verification status |
| `tags` | string[] | Categorization |
| `updated` | string | ISO 8601 timestamp |

### Network-Specific Addresses

| Network | Address Format | Example |
|---------|---------------|---------|
| Klever | Asset ID | `KUNAI-18TK` |
| Tron | Base58 | `TR7NHqje...` |
| EVM | Hex (checksummed) | `0x1234...` |
| Solana | Base58 | `EPjFWdd5...` |

## Verification Requirements

### Tokens

| Requirement | How to Verify |
|-------------|---------------|
| Contract exists | Block explorer link |
| Correct decimals | Contract read |
| Official token | Project website/social |
| Active usage | Trading volume > 0 |

### Scam Reports

| Requirement | Evidence |
|-------------|----------|
| Confirmed scam | Multiple reports |
| Address/domain | Exact string |
| Scam type | Category classification |
| Timeline | First reported date |

### Validators

| Requirement | How to Verify |
|-------------|---------------|
| Active status | On-chain query |
| Commission rate | Current on-chain value |
| Identity | Website/social links |

## Questions?

- Open an [Issue](https://github.com/fbsobreira/wallet-data/issues) for questions
- Use [Discussions](https://github.com/fbsobreira/wallet-data/discussions) for ideas
- Tag maintainers for urgent security reports

Thank you for helping make Hexis Wallet safer and more useful for everyone!
