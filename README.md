# OpenClaw Quickstart

Interactive setup wizard that takes you from zero to a running OpenClaw AI agent on Hostinger VPS in ~15 minutes.

The wizard opens browser tabs, navigates to the right pages, fills forms, and pauses at sensitive checkpoints (password, payment, 2FA) for you to handle.

## What you get

- Self-hosted AI agent (OpenClaw) running on your own VPS
- Connected to Telegram bot (chat with your agent from anywhere)
- Hardened with Tailscale + UFW + Fail2ban (optional)
- No vendor lock-in — you own the keys, the VPS, and the data

## Requirements

- [Claude Code](https://claude.com/claude-code) (free CLI)
- [Playwright MCP](https://github.com/microsoft/playwright-mcp) (free browser automation)
- Chrome or Edge browser
- Hostinger account + payment method (~$9–14/month VPS)
- An Anthropic API key (or OpenAI / Gemini / Grok)

## Install

### macOS / Linux

```bash
curl -fsSL https://raw.githubusercontent.com/ariel198989/openclaw-quickstart-skill/main/install.sh | bash
```

### Windows (PowerShell)

```powershell
iwr https://raw.githubusercontent.com/ariel198989/openclaw-quickstart-skill/main/install.ps1 | iex
```

### Manual

1. Clone this repo
2. Copy the folder to `~/.claude/skills/openclaw-quickstart/` (or `%USERPROFILE%\.claude\skills\openclaw-quickstart\` on Windows)
3. Install Playwright MCP: `claude mcp add playwright npx @playwright/mcp@latest`
4. Restart Claude Code

## Usage

In Claude Code, type:

```
/openclaw-quickstart
```

Or just ask:

> Set me up with OpenClaw

The wizard takes over from there.

## What it does (12 steps)

1. Intro — opens `openclaw.ai`
2. Hostinger 1-Click OpenClaw plan
3. Signup / login (you handle password)
4. Payment (you handle card)
5. Configuration form — Gateway Token + API keys
6. Anthropic Console — creates `OPENCLAW` key
7. Waits for Deploy
8. Opens OpenClaw web UI
9. Telegram @BotFather — creates bot, extracts token
10. Pairing — connects bot to OpenClaw
11. Liveness test — sends first message
12. Optional hardening (Tailscale + UFW + Fail2ban)

## Security

- **No secrets touch a third-party server.** Everything happens between your browser and the official Hostinger / Anthropic / Telegram sites.
- The wizard never types passwords, card numbers, or 2FA codes — it pauses and lets you.
- API keys created during setup are stored only in your Hostinger VPS configuration.
- Source is fully open — read `SKILL.md` to see exactly what runs.

## Free?

Yes. The skill, Claude Code, Playwright MCP, and the install are all free.

You pay:
- Hostinger VPS (~$9–14/month) — required, your own account
- Anthropic / OpenAI API usage (~$3–15/month for light use) — required, your own account

We get nothing from your install. Optional: if you want to support the project, the wizard uses our Hostinger affiliate link (no extra cost to you).

## Credits

Built on top of [OpenClaw](https://openclaw.ai) by the OpenClaw team.

Inspired by [@bff_arber](https://www.youtube.com/watch?v=-yM-MjHlyX4)'s walkthrough video.

## License

MIT
