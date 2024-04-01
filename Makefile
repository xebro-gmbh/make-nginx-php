#--------------------------
# xebro GmbH - nginx-php - 0.0.2
#--------------------------

nginx-php.bash: ## start nginx bash
	@${DOCKER_COMPOSE} ${DOCKER_FILES} run --rm nginx bash

nginx-php.validate: ## Validate nginx config
	@${DOCKER_COMPOSE} ${DOCKER_FILES} run --rm nginx-php nginx -t

nginx-php.logs: ## show logs for nginx container
	@${DOCKER_COMPOSE} ${DOCKER_FILES} logs -f nginx

nginx-php.build.dev: ## Build dev container
	@${DOCKER_COMPOSE} ${DOCKER_FILES} build nginx-php

nginx-php.start:
	@${DOCKER_COMPOSE} ${DOCKER_FILES} up nginx-php

nginx-php.build.prod: ## Build prod container
	@docker build --no-cache --target prod -f "./docker/nginx/Dockerfile" -t "${PROJECT_NAME}_nginx:latest" .

nginx-php.install:
	$(call headline,"Installing nginx-php")
	$(call add_config,".env","docker/nginx-php/.env")

install: nginx-php.install
