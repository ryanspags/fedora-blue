#!/usr/bin/env bash
set -euo pipefail

PROTONPASS_VERSION="1.40.2"
PROTONPASS_DIR="/tmp/protonpass"
PROTONPASS_RPM="proton-pass-${PROTONPASS_VERSION}-1.x86_64.rpm"
PROTONPASS_URL="https://proton.me/download/pass/linux/${PROTONPASS_RPM}"

PROTONPASS_SHA512="39b2ff0d2a7a2d394a70f1173480fa4cf2d45f431cd3ff389e0f02bc93cf735b8e74567ed81b6273cbc4b7c4b48f526a3aa811804de198c9fdc43765d639e2a0"

echo "Installing Proton Pass ${PROTONPASS_VERSION}..."

mkdir -p "${PROTONPASS_DIR}"

curl -fL --retry 5 \
  -o "${PROTONPASS_DIR}/${PROTONPASS_RPM}" \
  "${PROTONPASS_URL}"

echo "Verifying Proton Pass RPM SHA-512..."

echo "${PROTONPASS_SHA512}  ${PROTONPASS_DIR}/${PROTONPASS_RPM}" \
  | sha512sum --check --status

echo "Checksum verified."

echo "Installing Proton Pass RPM..."

rpm -i --force \
  "${PROTONPASS_DIR}/${PROTONPASS_RPM}"

rm -rf "${PROTONPASS_DIR}"

echo "Proton Pass ${PROTONPASS_VERSION} installed successfully."
