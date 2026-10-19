# FOMO Bot

Hackathon project, built live Oct 19 2026, 11:45 AM–3:15 PM PT. Submissions are due at 3:15, a hard deadline. Strategy, timeline and judge notes are in `PREP.md` (gitignored; read it first).

## Who does what
Two people build this. Read the file for your user: `diego.md` (Diego) or `lukas.md` (Lukas). Each lists the files that person owns, their tasks and their rules. Only edit your own files.

## What this is
A personal agent that finds tech events worth your time (reads your Google Calendar + Luma invites, suggests and calendars the best, writes a Doc digest); for hackathon picks it adds a judges/sponsors strategy brief (stretch, `hackathon-prep.md`). Pivoted from hackathon-only at ~12 PM Oct 19. **There's no app code: the agent is Cline.** The product is the skill at `.cline/skills/fomo-bot/SKILL.md` plus `setup.sh`. Don't add a Python or JS app, a web UI or a framework unless Diego asks.

## Tools (all tested Oct 19, ~1 AM)
- Cline CLI 3.0.73. Run it from this folder (skills are workspace-scoped). Model: free Nemotron 3.5 Super VL until the event credits arrive.
- Parallel Search MCP (`web_search`, `web_fetch`) and Parallel Task MCP (`createDeepResearch`, `getStatus`, `getResultMarkdown`), configured by `setup.sh`.
- Composio CLI. **Always call it by full path: `~/.local/bin/composio`.** Gmail, Google Docs and Google Calendar are linked for diegosrosen@gmail.com.
  - Luma invites: `~/.local/bin/composio execute GMAIL_FETCH_EMAILS -d '{"query":"from:luma-mail.com","max_results":10,"include_payload":false}'`
  - Find other tool slugs: `~/.local/bin/composio search "<task>"`; inputs: `~/.local/bin/composio tools info <SLUG>`

## Known gotchas
- A deep research run takes ~4.5 min and returns ~220k chars, which overflows Cline's context. Ask for a short, fixed-format brief (≤600 words).
- Luma pages may not show the date in what `web_fetch` returns, so fall back to `web_search`.
- Headless and scheduled Cline runs auto-approve every tool call.

## Rules
- Guardrail: the agent may create Docs and Calendar events only. It never sends, deletes or forwards email, never adds attendees, and creates events with `send_updates:none` (Composio's default emails attendees).
- Never commit `.env` or `PREP.md`. Never print API keys.
- Iterate fast: test the skill with `web_search`/`web_fetch` first; add deep research last.
- Diego is non-technical: explain decisions in a line, and give him exact commands to run in his own Terminal for anything interactive.
