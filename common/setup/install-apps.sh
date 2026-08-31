#!/bin/sh
# Platform packages first (they provide Go), then the shared Go tools.
set -eu

REPO=${REPO:-$(cd "$(dirname "$0")/../.." && pwd)}
OS=${OS:?OS must be set to linux or macos}

"$REPO/$OS/setup/install-apps.sh"

go install github.com/kinbiko/mokku/cmd/mokku@latest
go install github.com/kinbiko/semver/cmd/upversion@latest
