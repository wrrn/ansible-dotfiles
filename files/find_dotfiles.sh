#!/usr/bin/env bash

# The directory then dotfiles will be linked to.
TARGET_DIR=$1

# The directory where the dotfiles live.
STOW_DIR=$2

# Print out the dotfiles that live in both the TARGET_DIR and the STOW_DIR.
    EXISTING_DOTFILES=$(comm -12 \
     <(find "${TARGET_DIR}" -maxdepth 1 -exec basename {} \; | sort ) \
     <(find "${STOW_DIR}" -mindepth 1 -not -path "${package_dir}" -exec basename {} \; | sort))

# We do this to make stowing idempotent
for f in $EXISTING_DOTFILES; do
    if [ ! -a "${f}.bak" ]; then
        echo "${f}"
    fi
done
