#!/usr/bin/env bash
# Points bucket/bckupx-agent.json at a release: its version, download URL and
# SHA-256, all from that release's manifest.json on get.concentric.sh. The
# agent's release workflow runs this on every stable release.
#
#   ./update-manifest.sh 0.1.46
set -euo pipefail
version=${1:?usage: update-manifest.sh <version>}
[[ "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] || { echo "not a stable version: $version" >&2; exit 1; }

release=$(curl -fsSL "https://get.concentric.sh/$version/manifest.json")
file=$(jq -r '.artifacts.windows.file' <<<"$release")
sha=$(jq -r '.artifacts.windows.sha256' <<<"$release")
[[ "$file" == *.exe && "$sha" =~ ^[0-9a-f]{64}$ ]] || { echo "no Windows build in $version's manifest" >&2; exit 1; }

manifest=bucket/bckupx-agent.json
jq --indent 4 --arg v "$version" --arg url "https://get.concentric.sh/$version/$file#/bckupx-agent.exe" --arg sha "$sha" \
  '.version = $v | .architecture."64bit".url = $url | .architecture."64bit".hash = $sha' \
  "$manifest" > "$manifest.new"
mv "$manifest.new" "$manifest"
echo "bckupx-agent.json -> $version"
