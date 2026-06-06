#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd -- "$SCRIPT_DIR/.." && pwd)"
CACHE_DIR="$ROOT_DIR/.cache"
mkdir -p -- "$CACHE_DIR"
TMP_DIR="$(mktemp -d "$CACHE_DIR/install-low-network.XXXXXX")"

REGISTRY="${NPM_REGISTRY:-https://registry.npmmirror.com}"
MARKED_VERSION="${HEXO_RENDERER_MARKED_VERSION:-0.2.11}"

backup_file() {
  local file="$1"
  local backup="$TMP_DIR/${file#$ROOT_DIR/}"
  mkdir -p "$(dirname -- "$backup")"
  if [ -e "$file" ]; then
    cp -p -- "$file" "$backup"
  fi
}

restore_file() {
  local file="$1"
  local backup="$TMP_DIR/${file#$ROOT_DIR/}"
  if [ -e "$backup" ]; then
    cp -p -- "$backup" "$file"
  elif [ -e "$file" ]; then
    rm -f -- "$file"
  fi
}

cleanup() {
  restore_file "$ROOT_DIR/package.json"
  restore_file "$ROOT_DIR/api/package.json"
  restore_file "$ROOT_DIR/package-lock.json"
  restore_file "$ROOT_DIR/api/package-lock.json"
  rm -rf -- "$TMP_DIR"
}

patch_marked_dependency() {
  local manifest="$1"
  node - "$manifest" "$MARKED_VERSION" <<'NODE'
const fs = require('fs');

const manifest = process.argv[2];
const replacement = process.argv[3];
const pkg = JSON.parse(fs.readFileSync(manifest, 'utf8'));
const deps = pkg.dependencies || {};
const current = deps['hexo-renderer-marked'];

if (
  current === 'screeps/hexo-renderer-marked' ||
  current === 'github:screeps/hexo-renderer-marked' ||
  /^git\+https:\/\/github\.com\/screeps\/hexo-renderer-marked\.git/.test(current || '') ||
  /^git(\+ssh)?:\/\/git@github\.com[:/]screeps\/hexo-renderer-marked/.test(current || '')
) {
  deps['hexo-renderer-marked'] = replacement;
  pkg.dependencies = deps;
  fs.writeFileSync(manifest, `${JSON.stringify(pkg, null, 2)}\n`);
}
NODE
}

trap cleanup EXIT HUP INT TERM

backup_file "$ROOT_DIR/package.json"
backup_file "$ROOT_DIR/api/package.json"
backup_file "$ROOT_DIR/package-lock.json"
backup_file "$ROOT_DIR/api/package-lock.json"

if command -v vfox >/dev/null 2>&1 && [ -f "$ROOT_DIR/.vfox.toml" ]; then
  eval "$(cd "$ROOT_DIR" && vfox env --shell bash)"
fi

node - "$ROOT_DIR/package.json" <<'NODE'
const fs = require('fs');

const manifest = process.argv[2];
const pkg = JSON.parse(fs.readFileSync(manifest, 'utf8'));
const expected = pkg.engines && pkg.engines.node ? pkg.engines.node : '>=14 <23';
const major = Number(process.versions.node.split('.')[0]);

if (major < 14 || major >= 23) {
  console.error(`Unsupported Node.js ${process.version}; expected ${expected}.`);
  console.error('Switch Node with vfox before running this script.');
  process.exit(1);
}
NODE

patch_marked_dependency "$ROOT_DIR/package.json"
patch_marked_dependency "$ROOT_DIR/api/package.json"

export NPM_CONFIG_REGISTRY="$REGISTRY"
export NPM_CONFIG_PACKAGE_LOCK=false
export NPM_CONFIG_AUDIT=false
export NPM_CONFIG_FUND=false
export NPM_CONFIG_UPDATE_NOTIFIER=false

echo "Using Node $(node --version), npm $(npm --version), registry $REGISTRY"

npm install --package-lock=false --no-audit "$@"
npm --prefix "$ROOT_DIR/api" install --package-lock=false --no-audit "$@"
