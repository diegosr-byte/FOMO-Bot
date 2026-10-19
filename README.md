# FOMO Bot

**A personal agent that finds the tech events worth your time.** It reads your Google Calendar and your Luma invites, searches for upcoming hackathons, talks and conferences that fit you, adds the best to your calendar and writes you a cited digest in Google Docs. When the top pick is a hackathon, it also researches the judges and sponsors and writes a strategy brief.

Built in the open at the Cline × Parallel × Composio Hackathon (Open Source AI Week, SF, Oct 19 2026).

> Demo video: _TODO_

## Why
_TODO: one paragraph. 3 hackathons in 3 weeks, hours of prep each time, and events found by luck._

## How it works
There's no app code. The agent is [Cline](https://cline.bot) running one skill:

```
"find me events" / event URL / Gmail invite
        │
        ▼
Cline CLI + skill (.cline/skills/fomo-bot/SKILL.md)
        ├── Composio CLI: read Google Calendar + Gmail Luma invites (who you are, when you're free)
        ├── Parallel Search MCP: find and verify upcoming events
        ├── Parallel Task MCP: deep, cited research on hackathon judges and sponsors
        └── Composio CLI: Google Calendar (suggested events), Google Docs (digest + brief)
        │
        ▼
Ranked picks on your calendar + a Google Doc digest
```

A weekly `cline schedule` run produces a fresh digest every Monday.

## Guardrails
The agent creates Docs and Calendar events only. It never sends, deletes or forwards email, never adds attendees, and never notifies anyone, even in scheduled runs.

## Setup
Requires Node, a [Cline](https://cline.bot) account, a [Parallel](https://platform.parallel.ai) API key and a [Composio](https://composio.dev) account.

```sh
npm i -g cline && cline auth
curl -fsSL https://composio.dev/install | sh
composio login
composio link gmail && composio link googledocs && composio link googlecalendar
cp .env.example .env    # add your PARALLEL_API_KEY
./setup.sh              # connects Parallel's MCP servers to Cline
```

## Usage
Run from this folder (skills are workspace-scoped).
```sh
cline "/fomo-bot find me events this month"     # TODO: confirm the invocation
cline "/fomo-bot https://luma.com/<event>"
```

## Built with
[Cline](https://cline.bot) · [Parallel](https://parallel.ai) · [Composio](https://composio.dev)

## License
MIT
