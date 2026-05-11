---
name: openclaw-quickstart
description: |
  מדריך אינטראקטיבי שמוביל את המשתמש דרך דפדפן (Playwright MCP) לרישום מלא של סוכן OpenClaw עצמאי על Hostinger VPS, כולל מפתחות API, חיבור ערוץ Telegram, והקשחת אבטחה — מתחיל מאפס ומסיים בסוכן רץ. השתמש כשהמשתמש אומר "התקן OpenClaw", "תפעיל לי סוכן OpenClaw", "תכין לי VPS עם סוכן AI", "OpenClaw quickstart", "הקם בוט Telegram עם OpenClaw", או מבקש סוכן AI עצמאי על VPS. הסקיל פותח טאבים, מנווט, ועוצר ב-checkpoints שדורשים את המשתמש (תשלום, סיסמה, 2FA, צילום סיסמה לזיכרון של המשתמש).
---

# OpenClaw Quickstart — מדריך הקמה דרך הדפדפן

מטרת הסקיל: לקחת משתמש מאפס ל-OpenClaw רץ + מחובר ל-Telegram תוך ~15 דקות, בלי שהוא יצטרך לפתוח טאבים בעצמו או לזכור את הסדר.

הסקיל **לא** קונה VPS, לא מקליד סיסמאות, לא מאשר תשלום. הסקיל פותח את העמוד הנכון, ממלא מה שאפשר לאוטומציה, ועוצר בכל נקודה שבה צריך פעולת אנוש.

## דרישות לפני שמתחילים

לפני הפעלת הסקיל, ודא שלמשתמש יש:
- [ ] כרטיס אשראי / PayPal (~$9–14)
- [ ] כתובת אימייל פנויה לחשבון Hostinger
- [ ] מספר טלפון לאימות Telegram (אם אין לו חשבון)
- [ ] **Playwright MCP מחובר** — תלוי בכלים `mcp__playwright__*`. אם לא מחוברים — ה-skill נכשל בשלב 1.
- [ ] חיבור Chrome MCP אופציונלי כ-fallback אם Playwright לא זמין

שאל את המשתמש שאלה אחת לפני שמתחילים:
> יש לך כבר חשבון Hostinger? יש לך מפתח Anthropic API? יש לך בוט Telegram מקושר?
> (תשובה תקבע מאיזה שלב מתחילים — אפשר לדלג)

---

## שלבי המדריך (overview)

| # | שלב | מי עושה | משך |
|---|------|---------|------|
| 1 | פתיחת openclaw.ai (אופציונלי, הסבר על המוצר) | סוכן | 30s |
| 2 | Hostinger → תוכנית 1-Click OpenClaw | סוכן פותח, משתמש לוחץ | 1m |
| 3 | רישום / התחברות Hostinger | **משתמש** (סיסמה) | 2m |
| 4 | תשלום | **משתמש** (כרטיס) | 1m |
| 5 | טופס תצורת OpenClaw — מפתחות API | סוכן + משתמש | 3m |
| 6 | יצירת מפתח Anthropic | סוכן פותח, משתמש מאשר | 2m |
| 7 | המתנה ל-Deploy (Hostinger Docker Manager) | סוכן בודק status | 1–3m |
| 8 | פתיחת OpenClaw web UI | סוכן | 30s |
| 9 | יצירת בוט Telegram עם @BotFather | סוכן מנחה, משתמש מקליק ב-Telegram | 2m |
| 10 | Pairing — הדבקת token ב-OpenClaw + pairing code לבוט | סוכן | 1m |
| 11 | בדיקת חיים — הודעה ראשונה לבוט | משתמש | 30s |
| 12 | (אופציונלי) הקשחה — Tailscale + UFW + Fail2ban | סוכן ייצר prompt | 5m |

סה"כ: 15–20 דק'.

---

## שלב 0 — Preflight

בדוק ש-Playwright MCP מחובר:

```
mcp__playwright__browser_navigate({ url: "about:blank" })
```

אם נכשל — הודע למשתמש:
> Playwright MCP לא מחובר. תתקין: `claude mcp add playwright npx @playwright/mcp@latest` ותתחיל מחדש את Claude Code.

---

## שלב 1 — אינטרו (אופציונלי, אפשר לדלג)

```
mcp__playwright__browser_navigate({ url: "https://openclaw.ai" })
mcp__playwright__browser_take_screenshot({ fullPage: false })
```

הצג למשתמש משפט אחד: "זה המוצר — סוכן AI שרץ אצלך, מקבל הוראות בטלגרם/וואטסאפ. ממשיכים להזמנה?"

אם הוא אומר "כן/דלג/קדימה" — שלב 2.

---

## שלב 2 — Hostinger 1-Click OpenClaw

```
mcp__playwright__browser_navigate({ url: "https://www.hostinger.com/vps/openclaw" })
mcp__playwright__browser_snapshot()
```

זהה את כפתור "Choose plan" של **OpenClaw on VPS** (בד"כ KVM 2, $8.99/mo, 8GB RAM). אם יש כמה תוכניות — בחר KVM 2 (היא הברירת המחדל שמתועדת בסרטון של בני).

```
mcp__playwright__browser_click({ element: "Choose plan button on KVM 2", ref: "<from snapshot>" })
```

עצור ותגיד למשתמש:
> נוסיף לעגלה. תוכל לבחור תקופה (חודש/24 חודשים — 24 הכי משתלם). אגב, אם יש לך קופון — תגיד לי ואכניס.

---

## שלב 3+4 — רישום ותשלום (משתמש לבד)

הסוכן **לא** מקליד סיסמאות / פרטי כרטיס. כשמגיעים למסך login/signup:

```
mcp__playwright__browser_snapshot()
```

הצג את העמוד ותגיד:
> תירשם / תתחבר (זה השלב היחיד שאני לא נוגע — סיסמה אישית). תגיד לי "ממשיכים" כשתסיים תשלום ואני אקח משם.

המתן לאישור מילולי מהמשתמש.

---

## שלב 5 — טופס OpenClaw configuration

אחרי תשלום, Hostinger יציג טופס עם השדות:
- Gateway Token
- Anthropic API Key
- OpenAI API Key
- Gemini API Key
- X (Grok) API Key

**Gateway Token** — תייצר אחד אקראי חזק:

```python
import secrets
token = secrets.token_urlsafe(48)
```

הצג את הטוקן למשתמש ובקש שיעתיק לעצמו (יצטרך אותו אחר כך לחיבור ערוצים):
> שמור את הטוקן הזה במקום בטוח. הוא הגישה שלך לסוכן: `<TOKEN>`

מלא את שדה Gateway Token:

```
mcp__playwright__browser_fill_form({ fields: [{name:"Gateway Token", value:"<TOKEN>"}] })
```

**Anthropic API Key** — אם אין למשתמש, עבור לשלב 6. אם יש — מלא ומדלג.

---

## שלב 6 — יצירת מפתח Anthropic (טאב נפרד)

```
mcp__playwright__browser_tabs({ action: "new" })
mcp__playwright__browser_navigate({ url: "https://console.anthropic.com/settings/keys" })
mcp__playwright__browser_snapshot()
```

אם המשתמש לא מחובר — עצור:
> תתחבר לחשבון Anthropic שלך (או תירשם). תגיד "מוכן".

אחרי חיבור:

```
mcp__playwright__browser_click({ element: "Create Key button", ref: "..." })
mcp__playwright__browser_fill_form({ fields: [{name:"key name", value:"OPENCLAW"}] })
mcp__playwright__browser_click({ element: "Create button", ref: "..." })
mcp__playwright__browser_snapshot()
```

המפתח (`sk-ant-api03-...`) מוצג פעם אחת בלבד. צלם screenshot והעתק לזיכרון:

```
mcp__playwright__browser_take_screenshot({ filename: "anthropic-key.png" })
```

הזהר את המשתמש:
> זה המפתח. אני מעתיק לטופס Hostinger עכשיו, אבל שמור גם אצלך — Anthropic לא יראה אותו שוב.

חזור לטאב Hostinger:

```
mcp__playwright__browser_tabs({ action: "select", index: 0 })
mcp__playwright__browser_fill_form({ fields: [{name:"Anthropic API Key", value:"<KEY>"}] })
mcp__playwright__browser_click({ element: "Submit / Continue", ref: "..." })
```

מפתחות אחרים (OpenAI/Gemini/Grok) — אופציונליים. שאל אם המשתמש רוצה לחבר אחד מהם עכשיו או לדלג.

---

## שלב 7 — המתנה ל-Deploy

Hostinger יעביר ל-Docker Manager. ה-container נכנס למצב **Deploying** ולוקח 1–3 דקות.

```
mcp__playwright__browser_navigate({ url: "https://hpanel.hostinger.com/vps" })
mcp__playwright__browser_wait_for({ text: "Running", time: 300 })
```

או polling ידני כל 30 שניות:

```
mcp__playwright__browser_snapshot()
# חפש "Running" status, אם "Deploying" — חכה
```

כשרץ — מצא את כפתור **Open** ליד `openclaw-<random>` והקלק:

```
mcp__playwright__browser_click({ element: "Open button on openclaw container", ref: "..." })
```

זה פותח טאב חדש עם **OpenClaw web UI**.

---

## שלב 8 — OpenClaw web UI

בטאב החדש:

```
mcp__playwright__browser_snapshot()
```

אמור לראות ממשק chat עם "Assistant Ready to chat" ושוליים: Overview / Channels / Instances / Sessions / Usage / Cron Jobs.

עצור ותגיד למשתמש:
> הסוכן חי! עכשיו נחבר לו טלגרם.

---

## שלב 9 — יצירת בוט Telegram

אם המשתמש יש לו כבר בוט — בקש את ה-HTTP token ודלג ל-10.

אחרת:

```
mcp__playwright__browser_tabs({ action: "new" })
mcp__playwright__browser_navigate({ url: "https://web.telegram.org/k/#@BotFather" })
```

אם משתמש לא מחובר ל-Telegram Web — עצור, צלם QR, תן הוראה:
> סרוק את ה-QR עם אפליקציית Telegram → Settings → Devices → Link Desktop Device.

כשמחובר, ה-thread עם BotFather פתוח. הזרם:

1. שלח `/newbot`
2. BotFather יבקש שם תצוגה — בקש מהמשתמש שם (למשל "AI Assistant שלי")
3. BotFather יבקש username (חייב להסתיים ב-`bot`) — הצע: `<userhandle>_openclaw_bot`
4. BotFather מחזיר טוקן בפורמט `123456:ABC-...`

```
mcp__playwright__browser_type({ element: "message input", ref: "...", text: "/newbot" })
mcp__playwright__browser_press_key({ key: "Enter" })
# המתן לתגובה
mcp__playwright__browser_snapshot()
```

חזור על השלבים האינטראקטיביים, חלץ את הטוקן מההודעה האחרונה של BotFather (regex `\d+:[A-Za-z0-9_-]{35}`).

הצג למשתמש:
> השגתי את הטוקן: `<BOT_TOKEN>`. עכשיו אני מחבר אותו ל-OpenClaw.

---

## שלב 10 — Pairing

חזור לטאב OpenClaw:

```
mcp__playwright__browser_tabs({ action: "select", index: <openclaw_tab> })
mcp__playwright__browser_type({
  element: "chat input",
  ref: "...",
  text: "תחבר את הבוט: <BOT_TOKEN>"
})
mcp__playwright__browser_press_key({ key: "Enter" })
```

הסוכן יבצע tool calls פנימיים ויחזיר **pairing code** בפורמט `[A-Z0-9]{8}`. צלם והעבר לטלגרם:

```
mcp__playwright__browser_tabs({ action: "select", index: <telegram_tab> })
# פתח שיחה עם הבוט החדש שיצרת (חיפוש לפי username)
mcp__playwright__browser_navigate({ url: "https://t.me/<bot_username>" })
mcp__playwright__browser_type({
  element: "telegram input",
  ref: "...",
  text: "openclaw pairing approve telegram <PAIRING_CODE>"
})
```

---

## שלב 11 — בדיקת חיים

עצור ותגיד למשתמש:
> תשלח לבוט הודעה: "היי, מי אתה?" — אם הוא עונה, הסיימת.

המתן לאישור.

---

## שלב 12 (אופציונלי) — הקשחה

שאל:
> רוצה לאבטח את ה-VPS עכשיו? Tailscale + UFW + Fail2ban + allowlist רק לך. ~5 דק'.

אם כן — הצמד את ה-prompt מ-`templates/secure-server.md` והדבק לצ'אט OpenClaw. הסוכן עצמו יריץ את הצעדים (זה ה-superpower של OpenClaw).

---

## הערות הצלחה / כשל

**Playwright UI דורש refs מתוך snapshot.** תמיד `browser_snapshot()` לפני `browser_click()` כדי לקבל ref עדכני. אל תנחש refs.

**Sensitive checkpoints — תמיד לעצור:**
- סיסמת login (Hostinger / Anthropic / Telegram)
- פרטי תשלום
- קוד 2FA / SMS
- אישור OAuth

**אל תשמור secrets לקובץ** — מפתחות API, גישות, טוקנים — רק להעביר בין טאבים. אם יוצרים screenshot של מפתח (שלב 6), המלץ למשתמש למחוק אותו אחרי שהעתיק.

**אם משהו מתפוצץ:** `mcp__playwright__browser_snapshot()` + `mcp__playwright__browser_console_messages()` + להחזיר למשתמש מה ראית. לא להמשיך עיוורית.

---

## Templates

- `templates/secure-server.md` — prompt מוכן להקשחת VPS (Tailscale + UFW + Fail2ban)
- `templates/bootstrap-prompt.md` — הודעה ראשונה לסוכן כדי שיציג עצמו ויסביר יכולות
- `templates/api-keys-checklist.md` — איפה להשיג כל מפתח אופציונלי (OpenAI / Gemini / Grok)
