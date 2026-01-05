# Wallet Data

Community-maintained blockchain data for [Hexis Wallet](https://github.com/fbsobreira/hexis-wallet).

This repository provides curated, verified data that powers wallet functionality including chain configurations, token lists, validator information, and security blocklists.

## Directory Structure

```
wallet-data/
├── chains/           # Blockchain metadata and token assets
│   ├── asset.schema.json
│   ├── tokenlist.schema.json
│   ├── tokenlist.json        # Master token list (all networks)
│   └── {network}/            # e.g., ethereum/, klever/, solana/
│       ├── info/
│       │   ├── info.json     # Chain config + native token metadata
│       │   └── logo.png      # Chain/native token logo
│       ├── assets/           # Token assets (community-contributed)
│       │   └── {address}/
│       │       ├── info.json
│       │       └── logo.png
│       └── tokenlist.json    # Network token list
├── validators/       # Staking validators (Klever, ETH pools)
├── dapps/            # Verified dApps (WalletConnect registry)
├── scams/            # Blocklist (scam addresses, phishing domains)
├── bridges/          # Cross-chain bridge contracts
├── nfts/             # Verified NFT collections
├── contacts/         # Public addresses (exchanges, foundations)
└── docs/             # Documentation
```

## Data Categories

| Directory | Purpose | Documentation |
|-----------|---------|---------------|
| `chains/` | Chain configs, RPC endpoints + token metadata | [TOKEN_LISTS.md](docs/TOKEN_LISTS.md) |
| `validators/` | Staking validators | [VALIDATORS.md](docs/VALIDATORS.md) |
| `dapps/` | Verified dApps | [DAPPS.md](docs/DAPPS.md) |
| `scams/` | Known scam addresses/domains | [SCAMS.md](docs/SCAMS.md) |
| `bridges/` | Cross-chain bridge contracts | [BRIDGES.md](docs/BRIDGES.md) |
| `nfts/` | Verified NFT collections | [NFTS.md](docs/NFTS.md) |
| `contacts/` | Public addresses | [CONTACTS.md](docs/CONTACTS.md) |

## Quick Start

### Fetching Data

Base URL for raw data:
```
https://raw.githubusercontent.com/fbsobreira/wallet-data/main/
```

Example endpoints:
```bash
# Master token list (all networks)
curl https://raw.githubusercontent.com/fbsobreira/wallet-data/main/chains/tokenlist.json

# Klever blockchain info
curl https://raw.githubusercontent.com/fbsobreira/wallet-data/main/chains/klever/info/info.json

# Ethereum token list
curl https://raw.githubusercontent.com/fbsobreira/wallet-data/main/chains/ethereum/tokenlist.json
```

### Supported Networks

| Category | Networks |
|----------|----------|
| **Layer 1** | Bitcoin, Ethereum, Solana, Tron, Cardano, Polkadot, Cosmos, Avalanche, NEAR, Aptos, Sui, Fantom, Hedera, Flow, MultiversX, Klever |
| **EVM Compatible** | BNB Smart Chain, Polygon, Harmony, Moonbeam, Astar, Chiliz, Reef |
| **Layer 2** | Arbitrum, Optimism, Base, Polygon zkEVM, Rollux, Syscoin NEVM |
| **Bitcoin Forks** | Litecoin, Bitcoin Cash, Dogecoin, Dash, DigiByte |
| **Polkadot/Kusama** | Kusama, Moonriver, Acala, Karura, Centrifuge, Altair, KILT, Avail |
| **Cosmos Ecosystem** | Celestia, CUDOS, Aura |
| **Other** | Stellar, XRP, Internet Computer, Binance Beacon, Syscoin, Shiden |

## Contributing

We welcome community contributions! Please read our [Contributing Guidelines](CONTRIBUTING.md) before submitting.

### How to Contribute

1. **Fork** this repository
2. **Create** a feature branch (`git checkout -b add-token-xyz`)
3. **Add/Update** data following the schema in the relevant documentation
4. **Update** the manifest version if applicable
5. **Submit** a Pull Request with verification links

### Contribution Types

- **Add tokens**: Submit new token metadata with contract verification
- **Report scams**: Help protect users by reporting known scam addresses
- **Add validators**: Submit verified validator information
- **Update endpoints**: Add RPC endpoints to `chains/{network}/info/info.json`
- **Fix errors**: Correct any inaccurate data with proper sources

## Verification Standards

All submitted data should meet these criteria:

- **Tokens**: Verified contract on block explorer, official project links
- **Validators**: Active and verifiable on-chain
- **dApps**: Legitimate project with security audit (preferred)
- **Scams**: Multiple reports or verified malicious activity
- **Endpoints**: Publicly accessible and responsive

## Data Integrity

- All JSON files are validated on PR submission
- Manifest versions are updated on changes
- Community review required for sensitive data (scams, verified badges)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Related Projects

- [Hexis Wallet](https://github.com/fbsobreira/hexis-wallet) - The wallet that uses this data

## Support

- **Issues**: [GitHub Issues](https://github.com/fbsobreira/wallet-data/issues)
- **Discussions**: [GitHub Discussions](https://github.com/fbsobreira/wallet-data/discussions)
