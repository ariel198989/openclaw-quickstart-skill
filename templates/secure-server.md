# הקשחת שרת — prompt מוכן

הדבק את ההודעה הבאה כצ'אט הראשון ל-OpenClaw. הוא יבצע את כל השלבים בעצמו ויחזור אליך עם תוצאות.

---

```
אבטח את השרת הזה:

1. התקן Tailscale ותן לי קישור auth.
2. ברגע שמחובר — הגדר את OpenClaw לעבוד דרך loopback בלבד (Tailscale Serve mode), כך שה-gateway זמין רק דרך Tailscale.
3. הפעל UFW: deny all incoming כברירת מחדל, אפשר SSH רק דרך הממשק של Tailscale.
4. התקן והפעל Fail2ban.
5. הגדר allowlist — רק מספר הטלגרם שלי (<TELEGRAM_USER_ID>) יכול לשלוח הודעות.
6. הרץ `openclaw security audit --deep` והצג לי את התוצאות.

חכה לאישור Tailscale ממני לפני שתיגע ב-firewall או ב-gateway config.
```

---

## אחרי הריצה

הסוכן יחזיר:
- קישור Tailscale auth — להעתיק לדפדפן ולאשר
- סטטוס UFW / Fail2ban / allowlist
- דוח security audit

אם משהו אדום — תבקש ממנו לתקן באותה שיחה.
