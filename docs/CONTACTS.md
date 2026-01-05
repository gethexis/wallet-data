# Public Addresses (Contacts)

Registry of known public addresses for exchanges, foundations, protocols, and notable entities.

## Repository Structure

```
contacts/
├── manifest.json           # Index of all contact lists
├── exchanges/
│   └── addresses.json
├── foundations/
│   └── addresses.json
├── protocols/
│   └── addresses.json
└── notable/
    └── addresses.json
```

## Manifest Schema

**File**: `contacts/manifest.json`

```json
{
  "version": "1.0.0",
  "updated": "2025-01-04T12:00:00Z",
  "categories": {
    "exchanges": {
      "version": "1.0.0",
      "count": 50
    },
    "foundations": {
      "version": "1.0.0",
      "count": 30
    },
    "protocols": {
      "version": "1.0.0",
      "count": 100
    },
    "notable": {
      "version": "1.0.0",
      "count": 25
    }
  }
}
```

## Contacts Schema

**File**: `contacts/{category}/addresses.json`

```json
{
  "category": "exchanges",
  "version": "1.0.0",
  "updated": "2025-01-04T12:00:00Z",
  "contacts": [
    {
      "id": "binance",
      "name": "Binance",
      "type": "exchange",
      "description": "Largest cryptocurrency exchange by volume",
      "website": "https://binance.com",
      "logo": "https://example.com/binance-logo.png",
      "addresses": {
        "ethereum": [
          {
            "address": "0x28C6c06298d514Db089934071355E5743bf21d60",
            "label": "Hot Wallet 1",
            "verified": true
          },
          {
            "address": "0x21a31Ee1afC51d94C2eFcCAa2092aD1028285549",
            "label": "Hot Wallet 2",
            "verified": true
          }
        ],
        "tron": [
          {
            "address": "TDqSquXBgUCLYvYC4XZgrprLK589dkhSCf",
            "label": "Hot Wallet",
            "verified": true
          }
        ],
        "klever": [
          {
            "address": "klv1...",
            "label": "Main Wallet",
            "verified": true
          }
        ]
      },
      "verified": true,
      "tags": ["cex", "major"]
    }
  ]
}
```

## Field Reference

### Contact Object

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `id` | string | Yes | Unique identifier |
| `name` | string | Yes | Entity name |
| `type` | string | Yes | Entity type |
| `description` | string | No | Brief description |
| `website` | string | No | Official website |
| `logo` | string | No | Logo URL |
| `addresses` | object | Yes | Addresses by network |
| `verified` | boolean | Yes | Verification status |
| `tags` | array | No | Categories |

### Address Object

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `address` | string | Yes | Blockchain address |
| `label` | string | No | Address label |
| `verified` | boolean | Yes | Verified by entity |

### Entity Types

| Type | Description |
|------|-------------|
| `exchange` | Centralized exchange |
| `dex` | Decentralized exchange |
| `foundation` | Project foundation |
| `protocol` | DeFi/protocol treasury |
| `custodian` | Custody service |
| `fund` | Investment fund |
| `notable` | Notable individual/entity |

## Category Examples

### Exchanges

```json
{
  "category": "exchanges",
  "contacts": [
    {
      "id": "binance",
      "name": "Binance",
      "type": "exchange",
      "addresses": {
        "ethereum": [
          {
            "address": "0x28C6c06298d514Db089934071355E5743bf21d60",
            "label": "Hot Wallet 1",
            "verified": true
          }
        ],
        "tron": [
          {
            "address": "TDqSquXBgUCLYvYC4XZgrprLK589dkhSCf",
            "label": "Hot Wallet",
            "verified": true
          }
        ]
      },
      "verified": true
    },
    {
      "id": "coinbase",
      "name": "Coinbase",
      "type": "exchange",
      "addresses": {
        "ethereum": [
          {
            "address": "0x71660c4005BA85c37ccec55d0C4493E66Fe775d3",
            "label": "Hot Wallet",
            "verified": true
          }
        ]
      },
      "verified": true
    },
    {
      "id": "kraken",
      "name": "Kraken",
      "type": "exchange",
      "addresses": {
        "ethereum": [
          {
            "address": "0x267be1C1D684F78cb4F6a176C4911b741E4Ffdc0",
            "label": "Hot Wallet",
            "verified": true
          }
        ]
      },
      "verified": true
    }
  ]
}
```

### Foundations

```json
{
  "category": "foundations",
  "contacts": [
    {
      "id": "klever-foundation",
      "name": "Klever Foundation",
      "type": "foundation",
      "website": "https://klever.org",
      "addresses": {
        "klever": [
          {
            "address": "klv1foundation...",
            "label": "Treasury",
            "verified": true
          }
        ]
      },
      "verified": true
    },
    {
      "id": "ethereum-foundation",
      "name": "Ethereum Foundation",
      "type": "foundation",
      "website": "https://ethereum.org",
      "addresses": {
        "ethereum": [
          {
            "address": "0xde0B295669a9FD93d5F28D9Ec85E40f4cb697BAe",
            "label": "Main Treasury",
            "verified": true
          }
        ]
      },
      "verified": true
    }
  ]
}
```

### Protocols

```json
{
  "category": "protocols",
  "contacts": [
    {
      "id": "uniswap",
      "name": "Uniswap",
      "type": "protocol",
      "addresses": {
        "ethereum": [
          {
            "address": "0x1a9C8182C09F50C8318d769245beA52c32BE35BC",
            "label": "Treasury",
            "verified": true
          }
        ]
      },
      "verified": true
    },
    {
      "id": "aave",
      "name": "Aave",
      "type": "protocol",
      "addresses": {
        "ethereum": [
          {
            "address": "0x25F2226B597E8F9514B3F68F00f494cF4f286491",
            "label": "Ecosystem Reserve",
            "verified": true
          }
        ]
      },
      "verified": true
    }
  ]
}
```

## Use Cases

### Transaction Labels

When displaying transactions, show recognizable names:

```
Sent to: Binance Hot Wallet
Received from: Ethereum Foundation
```

### Address Book

Pre-populate wallet address book with common destinations:

- Exchange deposit addresses
- Protocol treasuries
- Foundation wallets

### Security

Warn users about potential issues:

- "You're sending to an exchange address. Ensure you have the correct network."
- "This is a known protocol treasury, not a user address."

## Verification

### Criteria for `verified: true`

| Source | Verification Method |
|--------|---------------------|
| Exchange | Official documentation, API |
| Foundation | Official website, Etherscan labels |
| Protocol | Governance docs, verified contracts |
| Notable | Public statements, on-chain proof |

### Sources

- Etherscan/Tronscan address labels
- Official documentation
- On-chain governance
- Public announcements

## Adding Contacts

### Official Submission

Organizations can submit their own addresses:

```markdown
## Contact Submission (Official)

- Organization: MyExchange
- Type: exchange
- Website: https://myexchange.com

### Addresses
- Ethereum: 0x... (Hot Wallet)
- Tron: T... (Hot Wallet)

### Proof of Ownership
- [ ] Official domain email confirmation
- [ ] Signed message from address
- [ ] Listed on official website
```

### Community Submission

```markdown
## Contact Submission (Community)

- Organization: SomeProtocol
- Type: protocol

### Address
- Ethereum: 0x... (Treasury)

### Evidence
- Governance forum: [link]
- Etherscan label: [link]

Note: Marked as unverified until official confirmation
```

## Fetch URLs

```
Base: https://raw.githubusercontent.com/fbsobreira/wallet-data/main/contacts/

manifest.json          → /contacts/manifest.json
Exchanges              → /contacts/exchanges/addresses.json
Foundations            → /contacts/foundations/addresses.json
Protocols              → /contacts/protocols/addresses.json
```
