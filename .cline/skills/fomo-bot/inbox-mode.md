# Inbox mode (owner: teammate)

TODO: how the agent turns Luma invite emails from Gmail into structured events (name, date, URL, host) and what it infers about the user's interests from them. Keep it short: Step 1 of `SKILL.md` links here.

Query that works: `~/.local/bin/composio execute GMAIL_FETCH_EMAILS -d '{"query":"from:luma-mail.com","max_results":10,"include_payload":false}'`
