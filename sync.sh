#!/usr/bin/env bash
#
# sync.sh — mirror the live authoring copies from ~/.claude into this repo.
#
# Source of truth = ~/.claude (where the skills & commands actually run for you).
# This repo = the published copy students install from GitHub.
# Edit in ~/.claude, run this, then commit & push. Never edit the repo copy by hand.
#
# Usage:
#   ./sync.sh            # copy ~/.claude -> repo, then show what changed (git status)
#   ./sync.sh --push     # same, then commit & push to GitHub in one go
#
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE="${HOME}/.claude"

# --- map: live source  ->  repo destination -------------------------------
# Whole skill trees (rsync --delete so a file you remove in ~/.claude also
# disappears here). Each dest is scoped to one subtree, so nothing else in the
# repo (README, LICENSE, .claude-plugin/, plugin.json) is ever touched.
SKILL_DIRS=(
  "skills/design-journal"
  "skills/sprint-portfolio"
)
# Single command files.
COMMANDS=(
  "start-sprint"
  "log-decision"
  "build-portfolio"
)

echo "→ syncing from ${CLAUDE}  into  ${REPO}"

for d in "${SKILL_DIRS[@]}"; do
  src="${CLAUDE}/${d}/"
  dst="${REPO}/sprint-portfolio/${d}/"
  if [[ ! -d "$src" ]]; then
    echo "  ✗ missing live source: $src" >&2; exit 1
  fi
  mkdir -p "$dst"
  rsync -a --delete "$src" "$dst"
  echo "  ✓ $d"
done

for c in "${COMMANDS[@]}"; do
  src="${CLAUDE}/commands/${c}.md"
  dst="${REPO}/sprint-portfolio/commands/${c}.md"
  if [[ ! -f "$src" ]]; then
    echo "  ✗ missing live command: $src" >&2; exit 1
  fi
  cp "$src" "$dst"
  echo "  ✓ commands/${c}.md"
done

echo
echo "→ changes in repo:"
cd "$REPO"
git status --short
if git diff --quiet && git diff --cached --quiet; then
  echo "  (nothing changed — repo already matches ~/.claude)"
  exit 0
fi

if [[ "${1:-}" == "--push" ]]; then
  echo
  echo "→ committing & pushing…"
  git add -A
  git commit -m "sync: update plugin from ~/.claude authoring copies

Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>"
  git push
  echo "  ✓ pushed"
else
  echo
  echo "Review the diff above, then commit & push (or re-run with --push)."
fi
