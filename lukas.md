# Lukas's workstream (for Lukas's Claude Code)

Read `CLAUDE.md` and `README.md` first. Deadline: **submit at 3:15 PM PT**, feature freeze at **2:50** (moved by Diego).

Legend: `[x]` done, `[ ]` not done yet. "Written" means the file exists and is pushed; "tested" means it ran on real data.

## Setup first (about 10 min)
Composio does not install on Windows, so on this PC run everything below from **Ubuntu (WSL)**: open it with `wsl -d Ubuntu`, then `cd /mnt/c/Users/Administrator/Desktop/lukasz/FOMO-Bot`. If `cline` is not found there, run `source ~/.nvm/nvm.sh` first.

- [x] Clone the repo and create `.env` (`cp .env.example .env`).
- [x] Put YOUR OWN Parallel API key in `.env` (platform.parallel.ai; check it has Task API credits; never ask for Diego's key, never paste keys in chat), run `./setup.sh` and check `cline config mcp` lists `parallel-search` and `parallel-task` (the `cline mcp` command does not exist in this version). Key not yet confirmed by a real search.
- [x] Install the Composio CLI (v0.4.5, inside Ubuntu) and `composio login` as lukaszm39@gmail.com (done with the key in `.env`; plain `composio login` also works). Always call it as `~/.local/bin/composio`.
- [ ] Link the Google apps, one command each (it takes one app at a time): `~/.local/bin/composio link gmail`, then `googlecalendar`, then `googledocs`. Approve each link in the browser; add `--no-browser` to print the URL instead.
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

**Build order** (stop at any step and still have a demo). All steps are written into `people-outreach.md` but none is tested yet:
- [x] 1. **Goal input.** The user states one goal ("find a technical cofounder", "meet proptech investors"). Ask once; if the run is headless, read it from a `goal:` line in the prompt. Put it at the top of the Doc. Written as step 0 of `people-outreach.md` (done). Still open: Diego pastes the hook below into `SKILL.md`, and a test.
  - [ ] Diego pastes into `SKILL.md`: at the end of Step 1 add "Goal: use a `goal: <text>` line from the prompt; if none and the run is interactive, ask the user once for their goal for these events (see step 0 of `people-outreach.md`). Never ask in a scheduled or headless run." At Step 5, Doc: "start the Doc with a line `Goal: <goal>` (or `No goal given, so events are ranked by topic, not by people`)."
  - [ ] Test: `cline "/fomo-bot find me events this month. goal: find a technical cofounder"` and check the Doc starts with the goal line.
- [ ] 2. **People research** (`people-outreach.md`, ~40 min). For the top 5 candidates only: `web_search` the hosts, speakers, sponsors and public guest list. Per person: role, what they recently shipped or posted, source link. Use `createDeepResearch` for the #1 pick only (4.5 min, 600 words max, same rule as the hackathon brief).
- [ ] 3. **Score and explain.** Score each event against the goal by who is there, not the topic. One-line reason in the Doc: "Go to this one. The Parallel founder is judging and two YC proptech founders are attending." Add one-line skip reasons for the rest (cheap anti-FOMO, no extra build).
- [ ] 4. **Prep card per person** (Doc section, ~20 min): 3 people to find, what each recently shipped, one smart question each, and a 20-second intro tailored to that room.
- [ ] 5. **Outreach drafts** (~30 min). For each of the 3 people: a short, personal meeting request that cites the specific thing they shipped, one concrete ask (15-min coffee at the event), and the user's proposed slots taken from free Calendar time. Contact route, in order: a public email found on their site or the event page, otherwise a LinkedIn or X message written into the Doc for the user to paste. **Never guess an email address.**
- [ ] 6. **Stretch, only if time:** event crawl route with travel times (idea 3), post-event follow-up drafts (idea 5).

**Outreach safety (decided: drafts, not sends).** The agent saves outreach as Gmail **drafts** (find the slug with `~/.local/bin/composio search "create gmail draft"`, likely `GMAIL_CREATE_EMAIL_DRAFT`) and lists them in the Doc. The user reviews and presses send. Why: scheduled and headless runs auto-approve every tool call, so a real send would email strangers with no human check, and it breaks the guardrail. Cap at 3 drafts per run. Never add attendees to a Calendar event as a way to contact someone. In the demo, show the draft sitting in Gmail and say "one click to send".
- [ ] Confirm the real draft slug with `composio search` and test one draft to your own address.

**Needs Diego (SKILL.md, CLAUDE.md are his):**
- [ ] Amend the guardrail from "Docs and Calendar events only" to "Docs, Calendar events and Gmail **drafts**; still never sends, deletes or forwards email". Without this the draft step breaks the rules in `CLAUDE.md`, `diego.md`, `README.md` and the SKILL.md guardrail.
- [ ] Add the goal question to Step 1, call `people-outreach.md` after Step 4 (rank) for the top 5, and add a Step 7 hook for the drafts.
- [ ] Pick the rule for the demo: 3 real recipients are risky on stage, so draft to the user's own address as a stand-in or blur the recipient in the video.

**Pitch lines:** you are a visitor in SF this week, so you are the real user. Show one moment where Cline wrote a piece live (suggest: the outreach template). Tie-breakers: Parallel = people research, Composio = Calendar + Gmail drafts, Cline = built with it.

## Tasks, in order
1. **`inbox-mode.md`** (about 20 min). Write how the agent turns Luma invite emails into a list of `{name, date, url, host}` plus 3-5 inferred interests. Keep it short, since the agent reads it on every run.
   - [x] Written and pushed.
   - [ ] Tested with `~/.local/bin/composio execute GMAIL_FETCH_EMAILS -d '{"query":"from:luma-mail.com","max_results":10,"include_payload":false}'` on your own inbox.
   - [ ] Diego merged it into Step 1 of `SKILL.md`.
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
- The agent creates Docs, Calendar events and Gmail drafts only (draft rule pending Diego's OK, see the plan update). It never sends, deletes or forwards email, never adds attendees, and always uses `send_updates:none`.

## Git
Small commits. `git pull --rebase` before every push. Only touch your own files.
