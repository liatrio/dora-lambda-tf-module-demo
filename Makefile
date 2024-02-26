.PHONY: brew
brew:
	@echo "Installing brew packages"
	@brew bundle --force

.PHONY: sam
sam:
	@echo "Running Lambda through SAM Locally"
	sam build
	sam local start-api
