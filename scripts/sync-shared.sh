#!/usr/bin/env sh
# Builds each skill's references/ from shared/ so every skill installs standalone.
set -e
cd "$(dirname "$0")/.."
VERSION=$(cat shared/WORKFLOW_VERSION)
for stack_file in shared/stacks/*.md; do
  stack=$(basename "$stack_file" .md)
  dir="skills/$stack-guardrails-bootstrap"
  [ -d "$dir" ] || { echo "missing $dir" >&2; exit 1; }
  mkdir -p "$dir/references"
  cp shared/comments-and-history.md "$dir/references/"
  {
    echo "<!-- guardrails-workflow:start $VERSION $stack -->"
    echo "<!-- Fixed block. Do not edit; replace it whole to upgrade. Project notes go below the end marker. -->"
    echo
    cat shared/workflow-core.md
    echo
    cat "$stack_file"
    echo
    echo "<!-- guardrails-workflow:end -->"
    echo
    echo "## Specifics of this project"
    echo
    echo "<!-- Only what differs from the fixed block above, per step. Link to TESTING.md, SYSTEM_MAP.md and CONVENTIONS instead of repeating them. Keep it short. -->"
  } > "$dir/references/WORKFLOW.template.md"
done
echo "shared references synced ($VERSION)"
