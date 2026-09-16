#!/usr/bin/env bash
set -euo pipefail

echo "Enabling Tailscale daemon..."

mkdir -p /etc/systemd/system/multi-user.target.wants

ln -sf \
  /usr/lib/systemd/system/tailscaled.service \
  /etc/systemd/system/multi-user.target.wants/tailscaled.service

echo "Tailscale daemon enabled."
