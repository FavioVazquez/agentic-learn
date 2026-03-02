#!/usr/bin/env bash
# install.sh — Install agentic-learning skill
# Usage:
#   Workspace (current project):  bash install.sh
#   Global (all projects):        bash install.sh --global
#   Uninstall:                    bash install.sh --uninstall [--global]

set -e

SKILL_NAME="agentic-learning"
REPO="https://github.com/FavioVazquez/agentic-learn"
GLOBAL=false
UNINSTALL=false

for arg in "$@"; do
  case $arg in
    --global)   GLOBAL=true ;;
    --uninstall) UNINSTALL=true ;;
  esac
done

# Resolve install target
if [ "$GLOBAL" = true ]; then
  SKILLS_DIR="$HOME/.codeium/windsurf/skills/$SKILL_NAME"
  SCOPE="global"
else
  SKILLS_DIR="$(pwd)/.windsurf/skills/$SKILL_NAME"
  SCOPE="workspace"
fi

# Uninstall
if [ "$UNINSTALL" = true ]; then
  if [ -d "$SKILLS_DIR" ]; then
    rm -rf "$SKILLS_DIR"
    echo "✅ Uninstalled $SKILL_NAME ($SCOPE)"
  else
    echo "ℹ️  $SKILL_NAME not found at $SKILLS_DIR — nothing to remove"
  fi
  exit 0
fi

# Install
echo "Installing $SKILL_NAME ($SCOPE) → $SKILLS_DIR"

if command -v git &>/dev/null; then
  if [ -d "$SKILLS_DIR/.git" ]; then
    echo "Updating existing installation..."
    git -C "$SKILLS_DIR" pull --ff-only
  else
    mkdir -p "$(dirname "$SKILLS_DIR")"
    git clone --depth 1 "$REPO" "$SKILLS_DIR"
  fi
elif command -v curl &>/dev/null; then
  echo "git not found — downloading archive via curl..."
  mkdir -p "$SKILLS_DIR"
  curl -sL "$REPO/archive/refs/heads/main.tar.gz" \
    | tar -xz --strip-components=1 -C "$SKILLS_DIR"
else
  echo "❌ Neither git nor curl found. Please install one and retry." >&2
  exit 1
fi

echo ""
echo "✅ $SKILL_NAME installed ($SCOPE)"
echo ""
echo "Usage in Windsurf Cascade:"
echo "  @agentic-learning learn <topic>"
echo "  @agentic-learning quiz"
echo "  @agentic-learning struggle <task>"
echo "  @agentic-learning brainstorm <idea>"
echo "  @agentic-learning either-or <decision>"
echo "  @agentic-learning reflect"
echo "  @agentic-learning explain-first"
echo "  @agentic-learning space"
