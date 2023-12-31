export NAME_PREFIX = pds-portal-legacy
export APACHE_CONTAINER_NAME = $(NAME_PREFIX)-apache
export RUN_OPTIONS = 


build-images:	## Builds application for Docker Compose
	docker-compose build --progress=plain

build-images-nocache:	## Builds application for Docker Compose without the cache
	docker-compose build --no-cache

# This recipe assumes the wds-react-legacy and portal-legacy-docker repos are cloned at the same level
# in your local filesystem to test the relavent javascript builds.
copy-js-files:
	cp ../wds-react-legacy-clean/embedbuild/index.js* ./apache/var/www/portal-legacy/tools/doi/pds-wds/

destroy:	## Stops running app locally and removes Docker container images requiring a rebuild
	docker-compose down --rmi all

list-containers: ## List containers related to this project
	docker container ls --all --filter "ancestor=$(APACHE_CONTAINER_NAME)"

list-images: ## List images related to this project
	docker images --filter=reference='$(NAME_PREFIX)*'

login-apache: ## Open terminal window using apache container
	docker exec -it $(APACHE_CONTAINER_NAME) /bin/bash

open: ## open default browser to login selection interface
	open http://localhost.jpl.nasa.gov/

pull-submodules: ## pull down latest git submodules code
	git submodule update --recursive --remote

remove-containers:  ## Remove all containers related to this project.
	docker container ls --all | awk '{print $$2}' | grep "$(NAME_PREFIX)" | xargs -I {} docker rm -f {}

remove-images: remove-containers	## Remove all images related to this project. This depends on also removing project's containers; otherwise this target will fail if containers reference any images.
	docker images --all | awk '{print $$1}' | grep "${NAME_PREFIX}" | xargs -I {} docker rmi -f {}

restart:	## Restarts the application locally, does not reload environment variables
	docker-compose restart

restart-apache:	## Restarts the Apache service
	docker-compose restart apache

start:	## Starts up the application using Docker Compose
	docker-compose up $(RUN_OPTIONS)

start-detached: RUN_OPTIONS = "-d" ## Starts up the application with Docker Compose in detached mode
start-detached: start open

stop:	## Stops all running services
	docker-compose stop

stop-apache:	## Stops running Apache service
	docker-compose stop apache

watch-containers: ## Display a list of running containers that refreshes periodically
	watch docker container ls

# ----------------------------------------------------------------------------
# Self-Documented Makefile
# ref: http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
# ----------------------------------------------------------------------------
help:						## (DEFAULT) This help information
	@echo ====================================================================
	@grep -E '^## .*$$'  \
		$(MAKEFILE_LIST)  \
		| awk 'BEGIN { FS="## " }; {printf "\033[33m%-20s\033[0m \n", $$2}'
	@echo
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$'  \
		$(MAKEFILE_LIST)  \
		| awk 'BEGIN { FS=":.*?## " }; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'  \
#		 | sort
.PHONY: help
.DEFAULT_GOAL := help
