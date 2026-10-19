# FOMO Bot

**A personal agent that finds the tech events worth your time, and tells you which ones to skip.**

Built at the Cline × Parallel × Composio Hackathon (Open Source AI Week, San Francisco, Oct 19 2026). This repo is archived: it's a snapshot of what we built in one afternoon.

[Deck](docs/FOMO-Bot-deck.pdf) · [Personas](docs/personas.md)

## What it does
FOMO Bot reads your Google Calendar and Luma invites, searches for upcoming hackathons, talks and conferences, and ranks them against your **goal** ("meet AI founders", "find a technical cofounder", "get a job in tech"). It then:

- **Picks by people, not topic.** Parallel researches the hosts, speakers, sponsors and public guest list. Every pick gets a reason ("the Parallel founder is judging"), and every skipped event gets a one-line reason.
- **Calendars the best ones.** `[Suggested]` holds on your Google Calendar that never overlap something you already have.
- **Writes a cited digest** as a Google Doc, with prep cards: who to find, what they recently shipped, one question to ask and a 20-second intro.
- **Drafts outreach.** A short meeting request per person as a Gmail draft addressed to you, ready to review and paste. It never sends anything.
- **Says no for you (anti-FOMO).** Set a budget such as "max 3 events a week" and the agent keeps only that many.
- **Preps hackathons.** Given a hackathon URL, it researches the judges and sponsors and writes a strategy brief.
- **Runs on a schedule and from Telegram.** A fresh digest every Monday, or message the bot from your phone.

## How it works
There's no app code. The agent is [Cline](https://cline.bot) running one skill (`.cline/skills/fomo-bot/SKILL.md`):

```
"find me events" / event URL / Gmail invite
        │
        ▼
Cline CLI + skill
        ├── Composio: read Google Calendar + Gmail Luma invites (who you are, when you're free)
        ├── Parallel Search MCP: find and verify upcoming events
        ├── Parallel Task MCP: deep, cited research on people, judges and sponsors
        └── Composio: Google Calendar (suggested events), Google Docs (digest), Gmail (drafts)
        │
        ▼
Ranked picks on your calendar + a Google Doc digest + outreach drafts
```

## Guardrails
The agent creates Docs, Calendar events and Gmail drafts only. It never sends, deletes or forwards email, never adds attendees and never notifies anyone, including in scheduled runs. It never reads or prints API keys.

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
Run from this folder (skills are workspace-scoped). The `/fomo-bot` prefix is required.

```sh
cline "/fomo-bot find me events in the next 3 weeks. goal: meet AI founders and builders"
cline "/fomo-bot https://luma.com/<event>"      # one event; hackathons also get a judges/sponsors brief
cline "/fomo-bot scan my inbox"                 # list your Luma invites and inferred interests
```

Every Monday at 8 AM:
```sh
cline schedule create fomo-monday --cron "0 8 * * 1" --workspace "$PWD" \
  --prompt "/fomo-bot find me events in the next 3 weeks. goal: meet AI founders and builders"
```

From Telegram: create a bot with @BotFather, then lock it to your own user ID:
```sh
cline connect telegram -k <BOT_TOKEN> --allowed-user-id <YOUR_ID> --cwd "$PWD"
```
Message the bot `/fomo-bot help` for the manual.

## Team
Diego (@diegosr-byte) and Lukas.

## License
MIT
