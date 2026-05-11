#!/usr/bin/env bash
# OpenClaw Quickstart — installer for macOS / Linux
set -euo pipefail

REPO_URL="${OPENCLAW_REPO:-https://github.com/ariel198989/openclaw-quickstart-skill}"
SKILL_NAME="openclaw-quickstart"
SKILL_DIR="${HOME}/.claude/skills/${SKILL_NAME}"

echo "→ OpenClaw Quickstart installer"
echo ""

# Check Claude Code is installed
if ! command -v claude &> /dev/null; then
  echo "✗ Claude Code not found in PATH."
  echo "  Install from: https://claude.com/claude-code"
  exit 1
fi
echo "✓ Claude Code found"

# Check git is installed
if ! command -v git &> /dev/null; then
  echo "✗ git not found in PATH."
  exit 1
fi
echo "✓ git found"

# Clone or update skill
if [ -d "${SKILL_DIR}" ]; then
  echo "→ Updating existing install at ${SKILL_DIR}"
  cd "${SKILL_DIR}"
  git pull --ff-only
else
  echo "→ Cloning into ${SKILL_DIR}"
  mkdir -p "$(dirname "${SKILL_DIR}")"
  git clone --depth 1 "${REPO_URL}" "${SKILL_DIR}"
fi
echo "✓ Skill installed"

# Install Playwright MCP if missing
if ! claude mcp list 2>/dev/null | grep -q "playwright"; then
  echo "→ Installing Playwright MCP"
  claude mcp add playwright npx @playwright/mcp@latest
  echo "✓ Playwright MCP installed"
else
  echo "✓ Playwright MCP already present"
fi

echo ""
echo "Done. Restart Claude Code, then run:  /openclaw-quickstart"
