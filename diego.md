# Diego's workstream (for Diego's Claude Code)

Read `CLAUDE.md` first. Deadline: **submit at 3:15 PM PT**, feature freeze at **2:30**. Diego is non-technical: explain decisions in a line and give exact Terminal commands for anything interactive.

## You own (only you edit these)
- `.cline/skills/fomo-bot/SKILL.md`: the main flow (calendar + Luma invites, then find, verify, rank, then Calendar events + Doc digest)
- `.cline/skills/fomo-bot/hackathon-prep.md`: the hackathon branch (stretch)
- `setup.sh`, `CLAUDE.md`, this file

## Tasks, in order
1. **Get the flow working end to end** on Diego's real Google Calendar: `cline "/fomo-bot find me events in the next 3 weeks"`, run from the repo root. Iterate on `SKILL.md` until the picks are real, the dates are verified, and the Calendar events and Doc look good. Use `web_search`/`web_fetch` only; no deep research yet.
2. **Make the personalization visible** (this is the demo's wow moment). The Doc should say why each pick fits THIS user, citing a calendar event or invite, and should show a skipped event with its conflict ("skipped X: you're busy Thursday").
3. **Merge Lukas's `inbox-mode.md`** into Step 1 of `SKILL.md` once he pushes it. Keep the file short.
4. **Fix the invocation.** Find out whether `cline "/fomo-bot ..."` loads the skill or whether plain `cline "find me events"` does. Tell Lukas so he can fix the README.
5. **Hackathon branch** (only if step 1-2 work by ~1:45): fill in `hackathon-prep.md`. Deep research takes ~4.5 min and returns ~220k chars, so ask for a ≤600-word fixed-format brief. Save one finished run as a backup for the demo.
6. **2:30 freeze.** Save a backup run of the main flow. Help Lukas record the demo.

## Don't
- Don't edit Lukas's files (`lukas.md`, `inbox-mode.md`, `README.md`).
- Never commit `.env` or `PREP.md`. Never print API keys.
- The agent creates Docs and Calendar events only. It never sends, deletes or forwards email, never adds attendees, and always uses `send_updates:none`.

## Interface with Lukas
`inbox-mode.md` must tell the agent how to turn Luma invite emails into a list of `{name, date, url, host}` plus 3-5 inferred interests. `SKILL.md` Step 1 calls it.

## Git
Small commits. `git pull --rebase` before every push. Only touch your own files.
