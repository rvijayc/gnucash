# Installation Instructions

These were tested on a Ubuntu 24.04 system. Should also work in other systems (just may need a different Python version).

Create and activate a conda environment with a specific Python version and requirements pre-installed.

```shell
conda env create -f environment.yaml
conda activate gnc
```

Checkout this project.

```shell
git clone git@github.com:rvijayc/gnucash.git
```

Update `./build.sh` to change the following to your match your environment.

```bash
SRC_DIR="/home/vijayr/git/gnucash"
BUILD_DIR="build"
PREFIX="/home/vijayr/gnc"
```

Install all dependencies needed to build GNUCash with Python bindings enabled.

```shell
./build.sh deps
```

Then build and install GNUCash.
