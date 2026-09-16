#!/usr/bin/env bash
set -euo pipefail

OPENLOGI_VERSION="0.8.3"
OPENLOGI_RELEASE_URL="https://github.com/AprilNEA/OpenLogi/releases/download/v${OPENLOGI_VERSION}"
OPENLOGI_DIR="/tmp/openlogi"

OPENLOGI_RPM="openlogi-v${OPENLOGI_VERSION}-linux-amd64.rpm"
OPENLOGI_SHA256="778fa4969bbc948a755ec2f994d7eecd4585dab5fc7ad128bd48242ec30e3748"

echo "Installing OpenLogi ${OPENLOGI_VERSION}..."

mkdir -p "${OPENLOGI_DIR}"

curl -fL --retry 5 \
  -o "${OPENLOGI_DIR}/${OPENLOGI_RPM}" \
  "${OPENLOGI_RELEASE_URL}/${OPENLOGI_RPM}"

echo "Verifying OpenLogi RPM checksum..."

echo "${OPENLOGI_SHA256}  ${OPENLOGI_DIR}/${OPENLOGI_RPM}" \
  | sha256sum --check --status

echo "Checksum verified."

echo "Installing OpenLogi RPM without running package scriptlets..."

rpm \
  --install \
  --noscripts \
  "${OPENLOGI_DIR}/${OPENLOGI_RPM}"

echo "Configuring OpenLogi systemd user service..."

mkdir -p /etc/systemd/user/graphical-session.target.wants

ln -sf \
  /usr/lib/systemd/user/openlogi-agent.service \
  /etc/systemd/user/graphical-session.target.wants/openlogi-agent.service

echo "OpenLogi agent configured for graphical sessions."

rm -rf "${OPENLOGI_DIR}"

echo "OpenLogi ${OPENLOGI_VERSION} installed successfully."
