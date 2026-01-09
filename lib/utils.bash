#!/usr/bin/env bash
# SPDX-License-Identifier: AGPL-3.0-or-later
set -euo pipefail

TOOL_NAME="varnish"
BINARY_NAME="varnishd"

fail() { echo -e "\e[31mFail:\e[m $*" >&2; exit 1; }

list_all_versions() {
  local curl_opts=(-sL)
  [[ -n "${GITHUB_TOKEN:-}" ]] && curl_opts+=(-H "Authorization: token $GITHUB_TOKEN")
  curl "${curl_opts[@]}" "https://api.github.com/repos/varnishcache/varnish-cache/tags" 2>/dev/null | \
    grep -o '"name": "varnish-[^"]*"' | sed 's/"name": "varnish-//' | sed 's/"$//' | sort -V
}

download_release() {
  local version="$1" download_path="$2"
  local url="https://varnish-cache.org/_downloads/varnish-${version}.tgz"

  echo "Downloading Varnish $version..."
  mkdir -p "$download_path"
  curl -fsSL "$url" -o "$download_path/varnish.tgz" || fail "Download failed"
  tar -xzf "$download_path/varnish.tgz" -C "$download_path" --strip-components=1
  rm -f "$download_path/varnish.tgz"
}

install_version() {
  local install_type="$1" version="$2" install_path="$3"

  cd "$ASDF_DOWNLOAD_PATH"
  ./configure --prefix="$install_path" || fail "Configure failed"
  make -j"$(nproc)" || fail "Build failed"
  make install || fail "Install failed"
}
