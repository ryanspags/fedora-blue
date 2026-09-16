#!/usr/bin/env bash

set -euo pipefail

BLUEFERRY_VERSION="0.8.1"
BLUEFERRY_RELEASE_URL="https://github.com/erikwb/blueferry/releases/download/v${BLUEFERRY_VERSION}"
BLUEFERRY_DIR="/tmp/blueferry"

echo "Installing BlueFerry ${BLUEFERRY_VERSION}..."

mkdir -p "${BLUEFERRY_DIR}"

curl -fL --retry 5 -o "${BLUEFERRY_DIR}/blueferry-backend.rpm" \
  "${BLUEFERRY_RELEASE_URL}/blueferry-backend-${BLUEFERRY_VERSION}-1.fc43.noarch.rpm"

curl -fL --retry 5 -o "${BLUEFERRY_DIR}/blueferry-gtk.rpm" \
  "${BLUEFERRY_RELEASE_URL}/blueferry-gtk-${BLUEFERRY_VERSION}-1.fc43.noarch.rpm"

echo "Installing BlueFerry RPMs..."

dnf5 install -y \
  "${BLUEFERRY_DIR}/blueferry-backend.rpm" \
  "${BLUEFERRY_DIR}/blueferry-gtk.rpm"

rm -rf "${BLUEFERRY_DIR}"

echo "BlueFerry ${BLUEFERRY_VERSION} installed successfully."
