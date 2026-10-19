# Lukas's workstream (for Lukas's Claude Code)

Read `CLAUDE.md` and `README.md` first. Deadline: **submit at 3:15 PM PT**, feature freeze at **2:50** (moved by Diego).

Legend: `[x]` done, `[ ]` not done yet. "Written" means the file exists and is pushed; "tested" means it ran on real data.

## Setup first (about 10 min)
Composio does not install on Windows, so on this PC run everything below from **Ubuntu (WSL)**: open it with `wsl -d Ubuntu`, then `cd /mnt/c/Users/Administrator/Desktop/lukasz/FOMO-Bot`. If `cline` is not found there, run `source ~/.nvm/nvm.sh` first.

- [x] Clone the repo and create `.env` (`cp .env.example .env`).
- [x] Put YOUR OWN Parallel API key in `.env` (platform.parallel.ai; check it has Task API credits; never ask for Diego's key, never paste keys in chat), run `./setup.sh` and check `cline config mcp` lists `parallel-search` and `parallel-task` (the `cline mcp` command does not exist in this version). Key not yet confirmed by a real search.
- [x] Install the Composio CLI (v0.4.5, inside Ubuntu) and `composio login` as lukaszm39@gmail.com (done with the key in `.env`; plain `composio login` also works). Always call it as `~/.local/bin/composio`.
- [x] Link the Google apps: Gmail and Calendar linked. **Docs deliberately not linked** (your choice); the digest goes to a local file `digests/<date>.md` instead (gitignored). Link one app per command: `~/.local/bin/composio link gmail`, then `googlecalendar`. Approve each link in the browser; add `--no-browser` to print the URL instead.
- [x] Install Node and Cline 3.0.73 (inside Ubuntu).
- [ ] Log in to Cline: `cline auth`.
- [ ] Run from the repo root (skills are workspace-scoped). Confirm Cline can use `web_search` and `~/.local/bin/composio link gmail --list`.

## You own (only you edit these)
- `.cline/skills/fomo-bot/hackathon-prep.md`: the hackathon branch (the biggest piece)
- `.cline/skills/fomo-bot/people-outreach.md` (new): rank events by the people, prep cards, outreach drafts
- `.cline/skills/fomo-bot/inbox-mode.md`
- `README.md`, `lukas.md`
- The weekly schedule

Diego owns `SKILL.md`, `setup.sh` and `CLAUDE.md`. See `diego.md`.

## Plan update: rank by the people + outreach (the wow factor)
Core loop stays: discover, rank, calendar, Doc. New on top: the agent researches WHO is at each event, scores events against the user's goal, and drafts meeting requests to the right people. Demo on real SF events (Cerebral Valley + Luma), not mocks.

**Build order** (stop at any step and still have a demo). Items 1-5 are written into `people-outreach.md` (Part A ranks, from SKILL.md Step 4; Part B does prep and drafts, from Step 7). None is tested yet:
- [x] 1. **Goal input.** Uses a `goal:` line, else asks once (interactive), else infers one in headless runs. The Doc starts with `Goal: ...`. SKILL.md Step 1 hook: done by Diego.
  - [ ] Tested: the Doc starts with the goal line.
- [x] 2. **People research.** Top 5 events, at most 3 people each, at most 12 `web_search` calls. Deep research on the #1 pick only, started early and collected in Part B.
  - [ ] Tested: each person has a role, a recent thing shipped and a source link.
- [x] 3. **Score and explain.** 1-5 by who is there against the goal, weekly limit (default 3, or `limit:`), one line per pick and per skip.
  - [ ] Tested: every pick and every skip has a reason; no more picks than the limit.
- [x] 4. **Prep card** for the #1 pick: 3 people, what each shipped, one question each, a 20-second intro.
  - [ ] Tested.
- [x] 5. **Outreach drafts**, max 3, via `GMAIL_CREATE_EMAIL_DRAFT` (slug confirmed) to the user's own address (from `GMAIL_GET_PROFILE`). Body line 1 says where to send it: a found email, a company address, a labelled GUESSED email, or a LinkedIn/X message. Never puts a found or guessed address in To. Added to the Doc with `GOOGLEDOCS_UPDATE_DOCUMENT_MARKDOWN`.
  - [ ] Tested: drafts are in Gmail, addressed to you, nothing sent.
- [ ] 6. **Stretch: skipped.** Event crawl route and follow-up drafts are not built (freeze is 2:50). The skill file says so.

- [x] 7. **Onboarding profile** (`.clinerules/onboarding.md`, loaded in every Cline session, so it also works in Telegram). On the first message the bot asks: who are you, what are you building, and your goal (cofounder, clients or investors). Saved to `profile.md` (gitignored). `people-outreach.md` uses the profile goal when there is no `goal:` line.
  - [ ] Tested in Telegram: send "hi", answer the 3 questions, check `profile.md` exists; send "hi" again and it greets you by name.

- [x] 8. **Email finding + labelled guess** (`people-outreach.md` B2.5). Searches the event page, the person's site, GitHub, talk pages and the company team page; then a published company address; last resort a guess from the company's email pattern, labelled GUESSED with its source. Every draft also lists all other public routes found (X, LinkedIn, website/contact form, GitHub, booking link), so there is always a way to reach them. Work emails only, max 4 searches and 4 fetches per person, never in To.
  - [ ] Tested: every draft's line 1 has a source URL; guesses say GUESSED; no gmail-style guess.

- [x] 9. **Contact cards, no automatic outreach** (`people-outreach.md` B5). The bot's reply (Telegram or terminal) ends with one card per person: the message text, a `mailto:` link with subject and body filled in, and links to X, LinkedIn, website or contact form, GitHub and booking page. The user taps, pastes and sends. Automatic DMs on X or LinkedIn were dropped: LinkedIn bans automation, X DMs need a paid API, and it would break the never-send guardrail.
  - [ ] Tested in Telegram: the cards appear, the links open the right profiles, the mailto link opens a filled-in email.

**Outreach safety (decided: drafts, not sends).** Every draft is addressed to the user's own address, with the real recipient and route in the body. The user reviews and sends. Why: scheduled and headless runs auto-approve every tool call, so a real send would email strangers with no human check. Cap at 3 drafts per run. Never add attendees to a Calendar event as a way to contact someone. In the demo, show the draft sitting in Gmail and say "one click to send".

**Needs Diego (SKILL.md, CLAUDE.md are his):**
- [x] Guardrail widened to Docs, Calendar events and Gmail drafts (SKILL.md; done by Diego).
- [x] Goal in Step 1, `people-outreach.md` called from Step 4 and Step 7 (done by Diego).
- [x] Demo rule: drafts go to the user's own address (done by Diego).
- [x] `CLAUDE.md` guardrail updated to include Gmail drafts (done by Diego, ~12:50 PM).
- [ ] Allow labelled email guesses (needs Diego's OK). SKILL.md guardrail: replace "Never guess an email address." with "A guessed email may only appear in a draft's body, labelled GUESSED with its pattern source (see `people-outreach.md` B2.5); never put a guessed or found address in To." CLAUDE.md line 24: replace "never a guessed email" with "guessed emails only as labelled suggestions in the draft body". Until then the SKILL.md guardrail wins and the bot won't guess.
- [ ] SKILL.md: Step 1 reads `profile.md` (City, Building, Goal) before inferring from the inbox; the guardrail allows writing `profile.md` (onboarding) and `digests/` in the repo folder. Both files are gitignored.
- [ ] SKILL.md Step 5 and the guardrail: when Google Docs isn't connected, write the digest to `digests/<YYYY-MM-DD>.md` in the repo folder instead (and allow that one local file in the guardrail). `people-outreach.md` already does this; `.gitignore` has `digests/`. Needed so Lukas can test without Docs; the demo still uses a real Doc on Diego's account.

**Pitch lines:** you are a visitor in SF this week, so you are the real user. Show one moment where Cline wrote a piece live (suggest: the outreach template). Tie-breakers: Parallel = people research, Composio = Calendar + Gmail drafts, Cline = built with it.

## Tasks, in order
1. **`inbox-mode.md`** (about 20 min). Write how the agent turns Luma invite emails into a list of `{name, date, url, host}` plus 3-5 inferred interests. Keep it short, since the agent reads it on every run.
   - [x] Written and pushed.
   - [ ] Tested with `~/.local/bin/composio execute GMAIL_FETCH_EMAILS -d '{"query":"from:luma-mail.com","max_results":10,"include_payload":false}'` on your own inbox.
   - [x] Diego merged it into Step 1 of `SKILL.md` (Step 1 points to it).
2. **`hackathon-prep.md`** (until about 1:45). For a hackathon URL: start `createDeepResearch` (Parallel Task MCP) on the judges, each sponsor's API and past winners. Ask for a short fixed-format brief, 600 words max, with cited sources. A run takes about 4.5 minutes and returns about 220k chars, so never paste the raw result. While it runs, `web_search` each sponsor's docs. Then poll `getStatus` and `getResultMarkdown`. The output is: 3 idea angles aimed at these judges, the sponsor stack, a setup checklist and demo tips, each with a source link.
   - [x] Written and pushed.
   - [ ] Tested on today's hackathon, `https://luma.com/m8euvq9n`.
   - [ ] One finished run saved as a backup.
3. **Weekly schedule** (by 2:15). Scheduled runs auto-approve every tool call, so the guardrail below matters.
   - [ ] `cline schedule create ... --workspace <repo folder>` runs the skill every Monday (check `cline schedule --help` for the syntax).
   - [ ] Tested with `cline schedule trigger <id>`.
4. **README** (by 2:50).
   - [x] Added the key idea (rank by the people, outreach drafts, anti-FOMO).
   - [ ] Fill in the "Why" paragraph.
   - [ ] Fix the usage line once Diego confirms the invocation.
   - [ ] Add the schedule command.
   - [ ] Add the demo video link.

## Demo video, 2:50-3:05, together with Diego
Lukas records and narrates the hackathon brief and the weekly schedule. Diego drives the live run and narrates the calendar and picks. The limit is 2 minutes; aim for 1:50. Shape: the pain (0:15), the live run sped up (0:30), the Doc and Calendar events (0:30), the people pick, a prep card and the unsent Gmail draft (0:25), the hackathon brief and the close "fully open, install it with one script" (0:15). Use a saved run if the live one is slow.

Add to the video: the goal, the people-based pick with its reason, one prep card, and the outreach draft in Gmail (keep the schedule to one sentence).
- [ ] Dry run of the demo.
- [ ] Video recorded.

## Submit at 3:15 sharp
Lukas fills in the submission form and Diego checks it. Have the repo link and the video ready by 3:05.
- [ ] Repo link and video ready by 3:05.
- [ ] Form submitted and checked by Diego.

## Don't
- Don't edit `SKILL.md`, `setup.sh` or `CLAUDE.md`. Ask Diego instead.
- Never commit `.env`. Never print API keys.
- The agent creates Docs, Calendar events and Gmail drafts only (max 3 drafts per run, addressed to the user's own address; approved by Diego). It never sends, deletes or forwards email, never adds attendees, and always uses `send_updates:none`.

## Git
Small commits. `git pull --rebase` before every push. Only touch your own files.
