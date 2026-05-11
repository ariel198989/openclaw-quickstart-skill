# Walkthrough — What Happens When You Run It

A scene-by-scene tour of what the wizard actually does once you type `/openclaw-quickstart` in Claude Code.

Total time: **~15 minutes**. You handle 4 manual steps (password, payment, 2FA, sending a message). The wizard handles everything else.

---

## Scene 0 — Trigger

You type in Claude Code:

```
/openclaw-quickstart
```

Or just:

> "Set me up with OpenClaw"
> "התקן לי סוכן OpenClaw"

**What you see:** Claude responds:

> "Going to install OpenClaw on a fresh Hostinger VPS for you. This takes ~15 min. I'll drive your browser; you'll handle password / payment / 2FA when we get there. One question first — do you already have a Hostinger account or starting fresh?"

You answer. Wizard proceeds.

---

## Scene 1 — Preflight Check (5 sec)

**What the wizard does:**
- Verifies Playwright MCP is connected
- Opens a Chromium window

**What you see:** A new browser window opens. The wizard says:

> "Browser ready. Opening openclaw.ai for a 10-second intro — say 'skip' if you want to jump straight to the buy flow."

---

## Scene 2 — Product Intro (optional, 30 sec)

**What the wizard does:**
- Navigates to `openclaw.ai`
- Takes a screenshot
- Shows you the product page

**What you see:** Landing page with "The AI that actually does things." Wizard summarizes:

> "OpenClaw is a self-hosted AI agent. Runs on YOUR VPS, talks to you over Telegram / WhatsApp / any chat app. You own the keys, the data, the box. Continue?"

---

## Scene 3 — Hostinger 1-Click Plan (1 min)

**What the wizard does:**
- Opens `hostinger.com/vps/openclaw`
- Identifies the **OpenClaw on VPS** card (KVM 2: 2 vCPU / 8 GB RAM / 100 GB NVMe, ~$8.99/mo)
- Clicks "Choose plan"

**What you see:** Hostinger cart with KVM 2 plan added. Wizard says:

> "Plan in cart. You can pick the period (1 / 12 / 24 months — 24mo is best value). Have a coupon? Tell me and I'll apply."

---

## Scene 4 — Signup / Login (✋ YOU — 2 min)

**What the wizard does:**
- Detects the login screen
- **Stops.** Does not type your password.

**What you see:** Hostinger login/signup form. Wizard says:

> "This is the only part I don't touch — your personal password. Sign in or create your account. Tell me 'continue' when you're back on the cart page."

You sign up or log in. Type "continue".

---

## Scene 5 — Payment (✋ YOU — 1 min)

**What the wizard does:**
- Detects the payment page
- **Stops.** Does not type your card.

**What you see:** Checkout with credit card / PayPal form. Wizard says:

> "Same here — I don't touch payment. Pay with whatever you prefer. Hostinger will redirect you to a configuration form after; tell me when you see it."

You pay. Type "continue" when the OpenClaw configuration form appears.

---

## Scene 6 — Generate Gateway Token (10 sec)

**What the wizard does:**
- Generates a 64-char random URL-safe token using Python's `secrets`
- Fills it into the "Gateway Token" field

**What you see:** The form has a token like:

```
8H2Kp9-VfRz4xJ1mNbQwTcUyA0eIoPdLsGhRkWvMaEy6_-NXBgCDFGzZHJyKQpWoSwT
```

Wizard says (BIG WARNING):

> ⚠️ **Save this token. You need it for every channel you connect later. I cannot show it again.**
>
> Copy it somewhere safe (password manager / sticky note / encrypted file). When ready, say 'saved'.

You save it. Type "saved".

---

## Scene 7 — Anthropic API Key (2 min)

**What the wizard does:**
- Opens a new tab → `console.anthropic.com/settings/keys`

**What you see:** Anthropic Console. If not logged in:

> "Sign in to Anthropic Console (or create an account if you don't have one). Say 'ready' when you see the API Keys page."

After login, the wizard:
- Clicks "Create Key"
- Types name: `OPENCLAW`
- Clicks Create
- Takes a screenshot of the key dialog (so you have visual backup)
- Copies the `sk-ant-api03-...` value
- Switches back to the Hostinger tab
- Pastes the key into the "Anthropic API Key" field

**What you see:** Anthropic shows the key once, then the wizard says:

> ⚠️ **Anthropic only shows this key ONCE. I've pasted it into Hostinger AND screenshotted it. Copy from the screenshot to your password manager too — Anthropic won't reveal it again.**

Wizard asks about optional keys:

> "OpenAI / Gemini / Grok keys are optional. Want to add any now or skip? (You can always add later.)"

---

## Scene 8 — Submit Config & Wait for Deploy (1–3 min)

**What the wizard does:**
- Clicks Submit on the Hostinger configuration form
- Navigates to Hostinger Docker Manager
- Polls every 30 sec for the container status to change from `Deploying` → `Running`

**What you see:** A spinner / status indicator. Wizard says:

> "Container is deploying. This usually takes 1–3 minutes. I'll ping you the moment it's live."

When live:

> "✓ Container is Running. Opening OpenClaw web UI now."

---

## Scene 9 — First Look at OpenClaw UI (10 sec)

**What the wizard does:**
- Clicks "Open" button on the openclaw container row
- New tab opens with the OpenClaw chat interface

**What you see:** Clean chat UI with sidebar: `Chat / Overview / Channels / Instances / Sessions / Usage / Cron Jobs`. Top center: "Assistant — Ready to chat" with model `claude-opus-4-6`.

Wizard says:

> "Your agent is alive. Now let's give it a Telegram bot so you can talk to it from your phone."

---

## Scene 10 — Create Telegram Bot via BotFather (2 min)

**What the wizard does:**
- Opens a third tab → `web.telegram.org/k/#@BotFather`
- If you're not logged in to Telegram Web, shows a QR code and waits
- Once in BotFather chat, types `/newbot`

**What you see (Telegram Web):** BotFather messages. The wizard prompts you:

> "BotFather asks for a display name. What should we call your bot? (e.g. 'My AI Assistant')"

You answer. Wizard types it.

> "Now a username — must end in `bot`. Suggest: `myname_openclaw_bot`. OK or different?"

You answer. Wizard types it. BotFather returns the HTTP API token. Wizard extracts it via regex (`\d+:[A-Za-z0-9_-]{35}`) and confirms:

> "Got the token: `123456789:ABCdef...`. Pasting it into OpenClaw now."

---

## Scene 11 — Pairing OpenClaw ↔ Telegram (1 min)

**What the wizard does:**
- Switches to OpenClaw tab
- Types in the chat: "Connect this Telegram bot: `<token>`"
- The OpenClaw agent processes, runs tool calls, returns a **pairing code** (e.g. `9L73P3K3`)
- Wizard extracts pairing code from response
- Switches to Telegram, opens chat with your new bot (`t.me/<your_bot_username>`)
- Types: `openclaw pairing approve telegram 9L73P3K3`

**What you see:** OpenClaw confirms:

> "✓ Telegram channel paired. Allowlist: pending. Send me a message from `@your_handle` to authorize."

---

## Scene 12 — Liveness Test (✋ YOU — 30 sec)

**What the wizard does:**
- Stops and waits

**What you see:** Wizard says:

> "From your Telegram app (phone or desktop), send your new bot any message — try: 'היי, מי אתה?' or 'Hello, who are you?'. Tell me what it replies."

You send. Bot replies in the same language, introduces itself, lists capabilities.

> 🎉 **Done. Your agent is live, owned by you, talks over Telegram.**

---

## Scene 13 — Optional Hardening (5 min, optional)

Wizard asks:

> "Want to secure the VPS now? I'll install Tailscale (private network), UFW firewall, Fail2ban, and lock the Telegram bot to only respond to your number. ~5 min."

If yes — wizard pastes the prompt from `templates/secure-server.md` into OpenClaw chat. **The agent itself runs the steps** (this is OpenClaw's superpower):

1. Installs Tailscale, gives you an auth URL → you approve in browser
2. Binds OpenClaw gateway to loopback (only reachable via Tailscale)
3. Configures UFW: deny-all incoming, SSH only via Tailscale interface
4. Installs Fail2ban
5. Locks allowlist to your Telegram user ID
6. Runs `openclaw security audit --deep` and reports green/red findings

You confirm Tailscale auth in browser when prompted. That's it.

---

## What's Stored Where (Security Map)

| Secret | Where it lives |
|--------|---------------|
| Hostinger account password | Your password manager. Never seen by wizard. |
| Credit card | Hostinger. Never seen by wizard. |
| Gateway Token | Your password manager + Hostinger VPS config |
| Anthropic API Key | Your password manager + Hostinger VPS config |
| Telegram Bot Token | OpenClaw config (encrypted on VPS) |
| Pairing Code | Single-use, expires after pairing |

The wizard never writes any secret to a file outside your local machine. The repo source is fully open — read `SKILL.md` to verify.

---

## What If Something Breaks?

The wizard pauses at every error, takes a screenshot, and asks you what to do. It does NOT retry blindly.

Common breaks:
- **Hostinger demands phone verification** — happens for new accounts. You handle SMS, then say "continue".
- **Anthropic Console requires email verification** — same pattern.
- **BotFather rate-limits** — wait 60 sec, wizard retries.
- **Deploy stuck on `Deploying` >5 min** — wizard pings Hostinger support link, suggests refresh.
- **Pairing code rejected** — wizard regenerates, retries once. If still failing, dumps Telegram chat history and asks you to read.

---

## After You're Done

You have:
- ✅ Self-hosted AI agent running 24/7 on a VPS you own
- ✅ Telegram bot wired up — message your agent from anywhere
- ✅ (Optional) Hardened with Tailscale + UFW + Fail2ban
- ✅ A `memory/` folder on the VPS that the agent uses for long-term memory

**Next moves the agent can do for you:**
- "Check my Gmail and summarize unread"
- "Book a flight from TLV to JFK next Tuesday under $800"
- "Every morning at 7am, send me a Hebrew news digest from these 5 sites"
- "Watch this product page; ping me if price drops below $50"

Type any of those into the bot. The agent will install whatever channels/MCPs it needs.

---

## Total Time Breakdown

| Scene | Who | Time |
|-------|-----|------|
| 0 Trigger | You | 5s |
| 1 Preflight | Wizard | 5s |
| 2 Intro | Wizard | 30s (skippable) |
| 3 Hostinger plan | Wizard | 1m |
| 4 Signup | **You** | 2m |
| 5 Payment | **You** | 1m |
| 6 Gateway Token | Wizard | 10s |
| 7 Anthropic key | Wizard + you | 2m |
| 8 Deploy wait | Wizard | 1–3m |
| 9 Open UI | Wizard | 10s |
| 10 BotFather | Wizard + you | 2m |
| 11 Pairing | Wizard | 1m |
| 12 Liveness | **You** | 30s |
| 13 Hardening | Wizard (optional) | 5m |

**Total active time:** ~15 min (20 if you do hardening).
**Your hands on keyboard:** ~4 min (signup + payment + send-a-message + 1 Tailscale approval).
