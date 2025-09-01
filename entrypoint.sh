#!/bin/bash
set -e

ROOTFS_DIR="/home/steam/.fex-emu/RootFS"

if [ ! -d "$ROOTFS_DIR" ] || [ -z "$(ls -A $ROOTFS_DIR)" ]; then
  mkdir -p "$ROOTFS_DIR"
  (
    cd "$ROOTFS_DIR"
    FEXRootFSFetcher --distro-name "fedora" --distro-version "40" -y -x
  )
fi

# Run the command given as argument to the container
exec /usr/bin/FEXBash -c "$@"
