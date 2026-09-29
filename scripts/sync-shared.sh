#!/usr/bin/env sh
# Copies shared references into every specialized skill so each one installs standalone.
set -e
cd "$(dirname "$0")/.."
for dir in skills/*-guardrails-bootstrap; do
  [ "$dir" = "skills/project-guardrails-bootstrap" ] && continue
  mkdir -p "$dir/references"
  cp shared/comments-and-history.md "$dir/references/"
done
echo "shared references synced"
