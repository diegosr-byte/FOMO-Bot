# Lukas's workstream (for Lukas's Claude Code)

Read `CLAUDE.md` and `README.md` first. Deadline: **submit at 3:15 PM PT**, feature freeze at **2:30**.

## Setup first (about 10 min)
1. Clone the repo, then `cp .env.example .env` and put the Parallel API key in `.env` (get it from Diego in person, never in chat), then `./setup.sh`.
2. Install and log in to the Composio CLI, then `composio login` and `composio link gmail googlecalendar googledocs` with YOUR Google account. Always call it as `~/.local/bin/composio`.
3. Install Cline and log in: `npm i -g cline && cline auth`.
4. Run from the repo root (skills are workspace-scoped). Confirm Cline can use `web_search` and `composio connections list`.

## You own (only you edit these)
- `.cline/skills/fomo-bot/hackathon-prep.md`: the hackathon branch (the biggest piece)
- `.cline/skills/fomo-bot/inbox-mode.md`
- `README.md`, `lukas.md`
- The weekly schedule

Diego owns `SKILL.md`, `setup.sh` and `CLAUDE.md`. See `diego.md`.

## Tasks, in order
1. **`inbox-mode.md`** (about 20 min). Write how the agent turns Luma invite emails into a list of `{name, date, url, host}` plus 3-5 inferred interests. Test with `~/.local/bin/composio execute GMAIL_FETCH_EMAILS -d '{"query":"from:luma-mail.com","max_results":10,"include_payload":false}'` on your own inbox. Keep it short, since the agent reads it on every run. Push as soon as it works so Diego can merge it into Step 1.
2. **`hackathon-prep.md`** (until about 1:45). Fill in the stub. For a hackathon URL: start `createDeepResearch` (Parallel Task MCP) on the judges, each sponsor's API and past winners. Ask for a short fixed-format brief, 600 words max, with cited sources. A run takes about 4.5 minutes and returns about 220k chars, so never paste the raw result. While it runs, `web_search` each sponsor's docs. Then poll `getStatus` and `getResultMarkdown`. The output is: 3 idea angles aimed at these judges, the sponsor stack, a setup checklist and demo tips, each with a source link. Test on today's hackathon, `https://luma.com/m8euvq9n`, and save one finished run as a backup. Push when it works.
3. **Weekly schedule** (by 2:15). Make `cline schedule create ... --workspace <repo folder>` run the skill every Monday. Check `cline schedule --help` for the syntax. Test with `cline schedule trigger <id>`. Scheduled runs auto-approve every tool call, so the guardrail below matters.
4. **README** (by 2:30). Fill in the "Why" paragraph and fix the usage line once Diego confirms the invocation. Add the schedule command.

## Demo video, 2:30-3:00, together with Diego
Lukas records and narrates the hackathon brief and the weekly schedule. Diego drives the live run and narrates the calendar and picks. 60 seconds total: the pain, the live run, the Doc and Calendar events, the hackathon brief, then "fully open, install it with one script". Use a saved run if the live one is slow.

## Submit at 3:15 sharp
Lukas fills in the submission form and Diego checks it. Have the repo link and the video ready by 3:05.

## Don't
- Don't edit `SKILL.md`, `setup.sh` or `CLAUDE.md`. Ask Diego instead.
- Never commit `.env`. Never print API keys.
- The agent creates Docs and Calendar events only. It never sends, deletes or forwards email, never adds attendees, and always uses `send_updates:none`.

## Git
Small commits. `git pull --rebase` before every push. Only touch your own files.
