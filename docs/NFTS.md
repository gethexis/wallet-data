# NFT Collections

Registry of verified NFT collections for display and spam filtering in Hexis Wallet.

## Repository Structure

```
nfts/
├── manifest.json           # Index of all collection lists
├── ethereum/
│   └── collections.json
├── polygon/
│   └── collections.json
├── solana/
│   └── collections.json
└── spam/
    └── collections.json    # Known spam/scam collections
```

## Manifest Schema

**File**: `nfts/manifest.json`

```json
{
  "version": "1.0.0",
  "updated": "2025-01-04T12:00:00Z",
  "networks": {
    "ethereum": {
      "version": "1.0.0",
      "count": 500,
      "verified": 200
    },
    "polygon": {
      "version": "1.0.0",
      "count": 300,
      "verified": 100
    }
  },
  "spam": {
    "version": "1.0.0",
    "count": 1500
  }
}
```

## Collection Schema

**File**: `nfts/{network}/collections.json`

```json
{
  "network_id": "ethereum",
  "version": "1.0.0",
  "updated": "2025-01-04T12:00:00Z",
  "collections": [
    {
      "address": "0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D",
      "name": "Bored Ape Yacht Club",
      "symbol": "BAYC",
      "description": "A collection of 10,000 unique Bored Ape NFTs",
      "image": "https://example.com/bayc-logo.png",
      "banner": "https://example.com/bayc-banner.png",
      "type": "ERC721",
      "supply": 10000,
      "creator": "0x...",
      "created_at": "2021-04-23T00:00:00Z",
      "website": "https://boredapeyachtclub.com",
      "social": {
        "twitter": "@BoredApeYC",
        "discord": "https://discord.gg/...",
        "opensea": "https://opensea.io/collection/boredapeyachtclub"
      },
      "royalty": {
        "percentage": 2.5,
        "recipient": "0x..."
      },
      "traits": ["Background", "Clothes", "Eyes", "Fur", "Hat", "Mouth"],
      "verified": true,
      "featured": true,
      "tags": ["pfp", "blue-chip", "art"]
    }
  ]
}
```

## Spam Collection Schema

**File**: `nfts/spam/collections.json`

```json
{
  "version": "1.0.0",
  "updated": "2025-01-04T12:00:00Z",
  "spam_collections": [
    {
      "address": "0x1234...",
      "network": "ethereum",
      "name": "Free NFT Airdrop",
      "type": "airdrop-spam",
      "severity": "high",
      "description": "Mass airdropped spam with malicious website",
      "malicious_url": "free-nft-claim.com",
      "first_reported": "2025-01-01T00:00:00Z",
      "reports": 150
    }
  ]
}
```

## Field Reference

### Collection Object

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `address` | string | Yes | Contract address |
| `name` | string | Yes | Collection name |
| `symbol` | string | No | Token symbol |
| `description` | string | No | Brief description |
| `image` | string | No | Logo/profile image URL |
| `banner` | string | No | Banner image URL |
| `type` | string | Yes | Token standard |
| `supply` | number | No | Total supply |
| `creator` | string | No | Creator address |
| `created_at` | string | No | Creation date |
| `website` | string | No | Official website |
| `social` | object | No | Social links |
| `royalty` | object | No | Royalty info |
| `traits` | array | No | Trait categories |
| `verified` | boolean | Yes | Verification status |
| `featured` | boolean | No | Featured in wallet |
| `tags` | string[] | No | Categories/tags |

### Token Standards

| Type | Description |
|------|-------------|
| `ERC721` | Standard NFT |
| `ERC1155` | Multi-token standard |
| `SPL` | Solana NFT |
| `KDA-NFT` | Klever NFT |

### Tags

| Tag | Description |
|-----|-------------|
| `pfp` | Profile picture collection |
| `art` | Digital art |
| `gaming` | Gaming assets |
| `music` | Music NFTs |
| `metaverse` | Virtual land/items |
| `membership` | Access/membership |
| `blue-chip` | Established, high-value |

## Spam Types

| Type | Description |
|------|-------------|
| `airdrop-spam` | Unsolicited airdrop |
| `phishing` | Links to phishing site |
| `impersonation` | Fake version of real collection |
| `scam` | General scam collection |
| `offensive` | Offensive/inappropriate content |

## Network Examples

### Ethereum Collections

```json
{
  "network_id": "ethereum",
  "collections": [
    {
      "address": "0x23581767a106ae21c074b2276D25e5C3e136a68b",
      "name": "Moonbirds",
      "symbol": "MOONBIRD",
      "type": "ERC721",
      "supply": 10000,
      "verified": true,
      "tags": ["pfp", "art"]
    },
    {
      "address": "0x49cF6f5d44E70224e2E23fDcdd2C053F30aDA28B",
      "name": "Clone X",
      "symbol": "CloneX",
      "type": "ERC721",
      "supply": 20000,
      "verified": true,
      "tags": ["pfp", "metaverse", "rtfkt"]
    }
  ]
}
```

### Polygon Collections

```json
{
  "network_id": "polygon",
  "collections": [
    {
      "address": "0x...",
      "name": "Polygon Ape YC",
      "type": "ERC721",
      "verified": false,
      "tags": ["pfp"]
    }
  ]
}
```

## Verification Criteria

### For `verified: true`

| Criterion | Requirement |
|-----------|-------------|
| Contract | Verified on block explorer |
| Creator | Known/doxxed team or reputable |
| Activity | Active trading, not wash trading |
| Longevity | 30+ days since mint |
| Community | Active social presence |

### For `featured: true`

| Criterion | Requirement |
|-----------|-------------|
| Verification | Must be verified |
| Volume | Significant trading volume |
| Reputation | Well-known in community |
| Quality | High-quality art/utility |

## Spam Detection

Collections are marked as spam if:

- Mass unsolicited airdrops
- Links to malicious websites
- Impersonates legitimate collections
- Reported by multiple users
- Contains offensive content

### Wallet Behavior

| Spam Status | Recommended Action |
|-------------|-------------------|
| In spam list | Hide by default |
| Unknown | Show with caution |
| Verified | Display normally |

## Adding Collections

### Legitimate Collection

```markdown
## Collection Submission

- Name: MyNFTCollection
- Contract: 0x...
- Network: ethereum
- Type: ERC721
- Supply: 5000

### Verification
- Contract on Etherscan: [link]
- Official website: [link]
- OpenSea: [link]

### Checklist
- [ ] Contract verified on explorer
- [ ] Active for 30+ days
- [ ] No scam reports
- [ ] Official social links provided
```

### Spam Report

```markdown
## Spam Report

- Contract: 0x...
- Network: ethereum
- Name: "Fake BAYC Airdrop"
- Type: airdrop-spam

### Evidence
- Malicious URL in metadata
- Mass airdropped to random wallets
- Impersonates BAYC

### Impact
- Affected wallets: ~10,000
```

## Fetch URLs

```
Base: https://raw.githubusercontent.com/fbsobreira/wallet-data/main/nfts/

manifest.json          → /nfts/manifest.json
Ethereum collections   → /nfts/ethereum/collections.json
Spam collections       → /nfts/spam/collections.json
```
