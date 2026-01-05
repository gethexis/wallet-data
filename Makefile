# Wallet Data Makefile
# Usage: make [target]

.PHONY: all check fix build clean help

# Default target
all: check build

# Run all validation checks
check:
	@echo "Running validation..."
	@./scripts/validate.sh all

# Validate specific category
check-chains:
	@./scripts/validate.sh chains

check-validators:
	@./scripts/validate.sh validators

check-dapps:
	@./scripts/validate.sh dapps

check-scams:
	@./scripts/validate.sh scams

# Build all token lists
build:
	@echo "Building token lists..."
	@./scripts/build.sh all

# Build specific network
build-ethereum:
	@./scripts/build.sh ethereum

build-klever:
	@./scripts/build.sh klever

build-tron:
	@./scripts/build.sh tron

build-polygon:
	@./scripts/build.sh polygon

build-bsc:
	@./scripts/build.sh bsc

build-solana:
	@./scripts/build.sh solana

# Auto-fix common issues (placeholder for future implementation)
fix:
	@echo "Auto-fix not yet implemented"
	@echo "Run 'make check' to see issues"

# Clean generated files
clean:
	@echo "Cleaning generated files..."
	@find . -name ".DS_Store" -delete
	@find . -name "*.bak" -delete
	@echo "Clean complete"

# Install dependencies (macOS)
install-deps-macos:
	@echo "Installing dependencies..."
	@brew install jq imagemagick

# Install dependencies (Ubuntu)
install-deps-ubuntu:
	@echo "Installing dependencies..."
	@sudo apt-get install -y jq imagemagick file

# Validate a single token
# Usage: make validate-token NETWORK=ethereum ADDRESS=0x...
validate-token:
ifndef NETWORK
	$(error NETWORK is required. Usage: make validate-token NETWORK=ethereum ADDRESS=0x...)
endif
ifndef ADDRESS
	$(error ADDRESS is required. Usage: make validate-token NETWORK=ethereum ADDRESS=0x...)
endif
	@echo "Validating token: $(NETWORK)/$(ADDRESS)"
	@if [ -f "./chains/$(NETWORK)/assets/$(ADDRESS)/info.json" ]; then \
		jq . "./chains/$(NETWORK)/assets/$(ADDRESS)/info.json" > /dev/null && echo "JSON valid" || echo "JSON invalid"; \
		if [ -f "./chains/$(NETWORK)/assets/$(ADDRESS)/logo.png" ]; then \
			echo "Logo exists"; \
		else \
			echo "Logo missing"; \
		fi \
	else \
		echo "Token not found"; \
	fi

# Count tokens per network
count:
	@echo "Token counts by network:"
	@for dir in ./chains/*/assets; do \
		if [ -d "$$dir" ]; then \
			network=$$(dirname "$$dir" | xargs basename); \
			count=$$(ls -1 "$$dir" 2>/dev/null | wc -l | tr -d ' '); \
			echo "  $$network: $$count tokens"; \
		fi \
	done

# Show statistics
stats: count
	@echo ""
	@echo "Data categories:"
	@for category in chains validators dapps scams bridges nfts contacts; do \
		if [ -d "./$$category" ]; then \
			files=$$(find "./$$category" -name "*.json" | wc -l | tr -d ' '); \
			echo "  $$category: $$files JSON files"; \
		fi \
	done

# Help
help:
	@echo "Wallet Data Makefile"
	@echo ""
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  check              Run all validation checks"
	@echo "  check-chains       Validate chains (blockchain info + tokens)"
	@echo "  build              Build all token lists"
	@echo "  build-[network]    Build specific network (ethereum, klever, etc.)"
	@echo "  fix                Auto-fix common issues (placeholder)"
	@echo "  clean              Remove generated/temp files"
	@echo "  count              Count tokens per network"
	@echo "  stats              Show repository statistics"
	@echo "  validate-token     Validate single token (NETWORK=x ADDRESS=y)"
	@echo "  install-deps-macos Install dependencies on macOS"
	@echo "  install-deps-ubuntu Install dependencies on Ubuntu"
	@echo "  help               Show this help"
