# Lukas's workstream (for Lukas's Claude Code)

Read `CLAUDE.md` and `README.md` first. Deadline: **submit at 3:15 PM PT**, feature freeze at **2:30**.

## Setup first (about 10 min)
1. Clone the repo, then `cp .env.example .env` and put the Parallel API key in `.env` (get it from Diego in person, never in chat), then `./setup.sh`.
2. Install and log in to the Composio CLI, then `composio login` and `composio link gmail googlecalendar googledocs` with YOUR Google account. Always call it as `~/.local/bin/composio`.
3. Install Cline and log in: `npm i -g cline && cline auth`.
4. Run from the repo root (skills are workspace-scoped). Confirm Cline can use `web_search` and `composio connections list`.

## You own (only you edit these)
- `.cline/skills/fomo-bot/inbox-mode.md`
- `README.md` (the "Why" paragraph, the usage line, the demo link)
- `lukas.md`
- The weekly schedule setup, and the demo video and submission

## Tasks, in order
1. **`inbox-mode.md`** (about 30 min). Write how the agent turns Luma invite emails into a list of `{name, date, url, host}` plus 3-5 inferred interests. Test with `~/.local/bin/composio execute GMAIL_FETCH_EMAILS -d '{"query":"from:luma-mail.com","max_results":10,"include_payload":false}'` on your own inbox. Keep it short, since the agent reads it on every run. Push as soon as it works so Diego can merge it into Step 1 of `SKILL.md`.
2. **Weekly schedule** (by 2:15). Make `cline schedule create ... --workspace <repo folder>` run the skill every Monday. Check `cline schedule --help` for the syntax. Test with `cline schedule trigger <id>`. Scheduled runs auto-approve every tool call, so the guardrail below matters.
3. **README** (by 2:30). Fill in the "Why" paragraph and fix the usage line once Diego confirms the invocation. Add the schedule command to the README.
4. **Demo video, 60 seconds** (2:30-3:00): the pain, then the live run on Diego's calendar, then the Doc and Calendar events, then "fully open, install it with one script". Use a saved run if the live one is slow.
5. **Submit at 3:15 sharp.** Have the repo link and the video ready by 3:05.

## Don't
- Don't edit `SKILL.md`, `hackathon-prep.md`, `setup.sh` or `CLAUDE.md`. Ask Diego instead.
- Never commit `.env`. Never print API keys.
- The agent creates Docs and Calendar events only. It never sends, deletes or forwards email, never adds attendees, and always uses `send_updates:none`.

## Git
Small commits. `git pull --rebase` before every push. Only touch your own files.
