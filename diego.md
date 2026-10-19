# Diego's workstream (for Diego's Claude Code)

Read `CLAUDE.md` first. Deadline: **submit at 3:15 PM PT**, feature freeze at **2:30**. Diego is non-technical: explain decisions in a line and give exact Terminal commands for anything interactive.

## You own (only you edit these)
- `.cline/skills/fomo-bot/SKILL.md`: the main flow (calendar + Gmail, then find, verify, rank, then Calendar events + Doc digest)
- `setup.sh`, `CLAUDE.md`, `diego.md`

Lukas owns `hackathon-prep.md`, `inbox-mode.md`, `README.md` and the schedule. See `lukas.md`.

## Tasks, in order
1. **Make the main flow good** on Diego's real accounts: `cline "/fomo-bot find me events in the next 3 weeks"`, run from the repo root. A first run works end to end. Now improve it: picks are real and verified, interests come from Gmail history, no sold-out or already-started events, missing start times handled.
2. **Seed the demo.** Diego's Google Calendar is empty, so add 2-3 events that collide with good picks (for example a Thursday-evening block). Then the Doc can show "skipped X: you're busy Thursday". Delete the old `[Suggested]` test events first.
3. **Merge Lukas's `inbox-mode.md`** into Step 1 of `SKILL.md` as soon as he pushes it. Keep it short.
4. **Fix the invocation.** Find out whether `cline "/fomo-bot ..."` loads the skill or plain `cline "find me events"` does. Tell Lukas so he can fix the README.
5. **Wire in Lukas's `hackathon-prep.md`** (Step 6 of `SKILL.md`) once he pushes it, and test the full path on a hackathon pick.
6. **By 2:30, freeze.** Save a backup run of the main flow (the Doc and Calendar links), and do a dry run of the demo.

## Demo video, 2:30-3:00, together with Lukas
Diego drives the live run and narrates the personal part (calendar, conflict, picks). Lukas narrates the hackathon brief and the weekly schedule, and records. Use a saved run if the live one is slow.

## Don't
- Don't edit Lukas's files (`lukas.md`, `inbox-mode.md`, `hackathon-prep.md`, `README.md`).
- Never commit `.env` or `PREP.md`. Never print API keys.
- The agent creates Docs and Calendar events only. It never sends, deletes or forwards email, never adds attendees, and always uses `send_updates:none`.

## Interface with Lukas
- `inbox-mode.md` turns Luma invite emails into a list of `{name, date, url, host}` plus 3-5 inferred interests. `SKILL.md` Step 1 calls it.
- `hackathon-prep.md` takes a hackathon URL and returns a short cited brief to append to the Doc. `SKILL.md` Step 6 calls it.

## Git
Small commits. `git pull --rebase` before every push. Only touch your own files.
