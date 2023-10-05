# PDS Portal Repo

This repo contains all the web pages and information needed for the PDS Portal and pds.nasa.gov

## Setup

This repo uses git submodules to load in the portal-legacy repo. To set up your local machine follow these instructions:

```shell
# Clone this repo using your preffered method, https is shown here
git clone https://github.com/NASA-PDS/portal-legacy-docker.git

# Initialize and Update git submodules
git submodule update --init --recursive
```

For more information about working with git submodules, like how to fetch updated code, check out the [git submodules reference](https://git-scm.com/book/en/v2/Git-Tools-Submodules).