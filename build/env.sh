#!/bin/sh

set -e

if [ ! -f "build/env.sh" ]; then
    echo "$0 must be run from the root of the repository."
    exit 2
fi

# Create fake Go workspace if it doesn't exist yet.
workspace="$PWD/build/_workspace"
root="$PWD"
ccmdir="$workspace/src/github.com/ccm-chain"
if [ ! -L "$ccmdir/ccmchain" ]; then
    mkdir -p "$ccmdir"
    cd "$ccmdir"
    ln -s ../../../../../. ccmchain
    cd "$root"
fi

# Set up the environment to use the workspace.
GOPATH="$workspace"
export GOPATH

# Run the command inside the workspace.
cd "$ccmdir/ccmchain"
PWD="$ccmdir/ccmchain"

# Launch the arguments with the configured environment.
exec "$@"
