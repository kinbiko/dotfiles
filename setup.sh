#!/bin/sh
set -eu
cd "$(dirname "$0")"
exec common/setup/bootstrap.sh "$@"
