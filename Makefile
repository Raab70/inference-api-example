.PHONY: run build create-model

build: ## Build the docker image
	@docker-compose build

run: create-model ## Run locally
	@docker-compose up

create-model: build ## Run the training script to create a pickle file
	@docker-compose run --rm web python create_model.py

#################################################################################
# Self Documenting Commands                                                     #
#################################################################################

.DEFAULT_GOAL := show-help
.PHONY: show-help
show-help:
	@echo "$$(tput bold)Available rules:$$(tput sgr0)"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'