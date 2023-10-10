# PDS — Containerized Portal Legacy Repository

This repo contains a docker configuration that will allow you to run a container that has Apache configured to serve the contents of the [portal-legacy](https://github.com/NASA-PDS/portal-legacy/) repo.

## Setup

To set up your local machine follow these instructions:

### Clone the Repository

```shell
# Clone this repo using your preffered method, https is shown here
git clone https://github.com/NASA-PDS/portal-legacy-docker.git
```

### Pull git submodules

This repo uses git submodules to load in the portal-legacy repo. To pull down the code from the `portal-legacy` repo that we have integrated as a git submodule:

``` Shell
git submodule update --recursive --remote
```

If the `portal-legacy` repo has newer commits, our `portal-legacy` git submodule information will need to be updated. Run `git status` to check if the commit hash was updated so it can be committed. For more information about working with git submodules, like how to fetch updated code, check out the [git submodules reference](https://git-scm.com/book/en/v2/Git-Tools-Submodules).

### Running Docker Container

To run the docker container, ensure Docker Desktop is installed and running first, then build the containers, as needed, and start the containers.

Review the `Makefile` for other helpful recipes

```
make build-images
make start
```