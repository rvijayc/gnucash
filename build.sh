#!/usr/bin/env bash

set -e

SRC_DIR="/home/vijayr/git/gnucash"
BUILD_DIR="build"
PREFIX="/home/vijayr/gnc"

# Default parallel jobs: leave one core free
DEFAULT_JOBS=$(( $(nproc) - 1 ))
JOBS=${JOBS:-$DEFAULT_JOBS}

DEPS=(
  build-essential cmake pkg-config git doxygen
  libglib2.0-dev libgtk-3-dev libwebkit2gtk-4.1-dev libxml2-dev libxslt1-dev zlib1g-dev libsecret-1-dev
  guile-3.0-dev
  libgwenhywfar-core-dev libgwengui-gtk3-dev libaqbanking-dev libofx-dev
  libdbi-dev libdbd-mysql libdbd-pgsql libdbd-sqlite3
  gettext intltool libgettextpo-dev xsltproc
  swig python3-dev python3-pip python3-setuptools python3-wheel perl libfinance-quote-perl
  libicu-dev libboost-all-dev
  libgtest-dev
)

build_project() {
  mkdir -p "$BUILD_DIR"
  cmake -B "$BUILD_DIR" -S "$SRC_DIR" \
    -DWITH_PYTHON=ON \
    -DCMAKE_INSTALL_PREFIX="$PREFIX"
  # Run build with nice + ionice for system responsiveness
  nice -n 10 ionice -c2 -n7 cmake --build "$BUILD_DIR" -j"$JOBS"
}

case "$1" in
  build|"")
    build_project
    ;;
  install)
    nice -n 10 ionice -c2 -n7 cmake --build "$BUILD_DIR" --target install -j"$JOBS"
    ;;
  clean)
    rm -rf "$BUILD_DIR"
    echo "Build directory removed."
    ;;
  deps)
    sudo apt update
    sudo apt install -y "${DEPS[@]}"
    ;;
  *)
    echo "Usage: $0 [build|install|clean|deps]"
    echo "You can override parallel jobs with JOBS=N (default: $(nproc-1))."
    ;;
esac

