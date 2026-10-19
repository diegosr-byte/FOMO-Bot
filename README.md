# FOMO Bot

**A personal agent that finds the tech events worth your time.** It reads your Google Calendar and your Luma invites, searches for upcoming hackathons, talks and conferences that fit you, adds the best to your calendar and writes you a cited digest in Google Docs. When the top pick is a hackathon, it also researches the judges and sponsors and writes a strategy brief.

## The key idea: rank events by the people, not the topic
Most event finders match topics. FOMO Bot matches your **goal** ("find a technical cofounder", "meet proptech investors", "get hired at company X"). _(In progress, built at the hackathon.)_

1. **Research the people.** For each top event, Parallel researches the hosts, speakers, sponsors and the public guest list: role, what they recently shipped or posted, with sources.
2. **Pick with a reason.** "Go to this one. The Parallel founder is judging and two YC proptech founders are attending." Every skipped event gets a one-line reason.
3. **Prep card per person.** 3 people to find, what each recently shipped, one smart question each, and a 20-second intro tailored to that room.
4. **Outreach to set up meetings.** The agent writes a personal meeting request to each person, citing something they actually shipped and proposing slots from your free calendar time. It is saved as a Gmail **draft** for you to review and send, never sent automatically. If no public email exists, it gives you a LinkedIn or X message to paste.

5. **Anti-FOMO: the agent says no for you.** You set an energy budget, for example "max 3 events a week". The agent decides which events deserve a spot on your calendar, skips the rest and gives a one-line reason for each skip ("skipped X: you're busy Thursday, and Y has the same people"). You don't have to keep track of everything or worry about missing out, because the agent already made the choice.

Next on the list: an event crawl route with real travel times, and next-morning follow-up drafts ("who did you meet?").

Built in the open at the Cline × Parallel × Composio Hackathon (Open Source AI Week, SF, Oct 19 2026).

> Demo video: _TODO_

## Why
In three weeks I entered three hackathons. Each time I spent hours on prep: reading the event page, finding out who the judges were, checking every sponsor's docs. And I only found the events by luck, through a friend or a random invite. Calendar apps don't help, since they only show events you already know about. FOMO Bot does the finding and the prep for you, and it says no to the events that don't fit your week.

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
The agent creates Docs, Calendar events and Gmail drafts only. It never sends, deletes or forwards email, never adds attendees, and never notifies anyone, even in scheduled runs. Outreach stays a draft until you press send.

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
cline "/fomo-bot find me events in the next 3 weeks. goal: meet AI founders and builders"
cline "/fomo-bot https://luma.com/<event>"      # a specific event; hackathons also get a judges/sponsors brief
cline "/fomo-bot scan my inbox"                 # list your Luma invites and inferred interests
```
The `/fomo-bot` prefix is required; plain prompts don't load the skill.

**Every Monday at 8 AM:**
```sh
cline schedule create fomo-monday --cron "0 8 * * 1" --workspace "$PWD" \
  --prompt "/fomo-bot find me events in the next 3 weeks. goal: meet AI founders and builders"
```

**From your phone (Telegram):** create a bot with @BotFather, then run it locked to your own Telegram user ID:
```sh
cline connect telegram -k <BOT_TOKEN> --allowed-user-id <YOUR_ID> --cwd "$PWD"
```
Then message the bot `/fomo-bot find me events this week`.

## Built with
[Cline](https://cline.bot) · [Parallel](https://parallel.ai) · [Composio](https://composio.dev)

## License
MIT
