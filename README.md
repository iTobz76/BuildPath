# BuildPath

**Live demo:** [learn.perthhomelab.dev](https://learn.perthhomelab.dev)


Learn to code by building. Short, interactive lessons in **Swift**, **Python** and **HTML**, where every course ends with something you actually made.

- **Learn by doing:** gap-fills, reordering lines, fixing bugs and writing code, not just reading or watching.
- **Build something real:** each course's lessons add up to a finished project (a tip calculator, a personal web page).
- **Real-world projects:** a Linktree-style link page (HTML), a terminal quiz game (Python) and a SwiftUI habit counter (Swift), each built step by step, with code you can run or paste into your own app.
- **Works everywhere:** a native iOS app and a web app you can install to your home screen (PWA).
- **AI tutor that asks, not tells:** an "Ask the tutor" button on every step. It never gives the answer: it asks questions to help you work it out, and after a correct answer it checks you really understand by asking you to explain it back.
- **Daily streak:** practise a little each day to build a streak, shown with your best run and the last 7 days.
- **Your progress follows you:** sign in on any device and your lessons, XP and daily streak sync to your account.

## What's in this repo

| Folder | What it is |
|---|---|
| `ios/` | The SwiftUI iOS app sources, built on Linux/WSL with [xtool](https://xtool.sh) (no Mac needed) |
| `server/` | A [PocketBase](https://pocketbase.io) backend (logins, progress sync and the AI tutor route in `pb_hooks/`) that also serves the web app from `server/pb_public/` |

Course content lives in JSON: `courses.json` for the web app, and the `*CourseData.swift` files (JSON in a Swift string) for iOS. **Keep lesson IDs identical in both** so progress syncs correctly.

## Run the server

```bash
cd server
docker compose up -d --build
docker compose exec pocketbase /pb/pocketbase superuser upsert you@example.com 'A-LONG-PASSWORD'
```

Then open `http://<server-ip>:8090`. The admin panel is at `/_/`. If you expose it publicly, protect `/_/*` and `/api/collections/_superusers/*` (for example with Cloudflare Access). The `progress` collection is created automatically by `server/pb_migrations`.

Updating the web app: copy new files into `server/pb_public/`. No rebuild is needed.

## Turn on the AI tutor (optional)

The tutor runs on your server, so keys and addresses never reach the apps. Pick one backend in `server/.env` (copy `.env.example` first; `.env` is git-ignored, never commit it):

**Option A: your own Ollama (free to run).**
```
TUTOR_PROVIDER=ollama
OLLAMA_URL=http://<ollama-machine-ip>:11434
OLLAMA_MODEL=qwen2.5-coder:7b
```
Run `ollama pull qwen2.5-coder:7b` on the machine that hosts Ollama. Step-by-step instructions for a Windows PC are in `server/OLLAMA-SETUP.md`. If it isn't the same machine as the server, Ollama must listen on your network (`OLLAMA_HOST=0.0.0.0`), and port 11434 must be allowed through that machine's firewall. Keep it off the internet: only the BuildPath server needs to reach it. If that machine is asleep, the tutor says it is resting and everything else keeps working.

**Option B: Claude through the Anthropic API (pay-as-you-go).**
```
ANTHROPIC_API_KEY=...        # from https://platform.claude.com (formerly console.anthropic.com)
TUTOR_MODEL=claude-haiku-5-5
```
API usage is billed separately from claude.ai plans; set a spend limit in the Console.

Then `docker compose up -d --build` (or `docker compose restart` after editing `.env`).

Each signed-in user gets `TUTOR_DAILY_LIMIT` questions a day (default 40). The tutor never gives the answer: it asks questions, and after a correct answer it asks you to explain it back. Claude is shown the reference solution so it can judge your understanding; a small local model is not (set `TUTOR_SHARE_REFERENCE=true` to change that). Either way the server replaces any reply that contains the answer, a code block or no question.

## Build the iOS app (xtool)

1. Install xtool and its iOS SDK (see the xtool docs).
2. Create a project: `xtool new BuildPath`
3. Replace its generated Swift files with `ios/Sources/BuildPath/*.swift`
4. Set the server address in `Sync.swift` (`SyncManager.baseURL`).
5. Connect your iPhone and run `xtool dev`.

## Never commit

- `server/pb_data/` (the database with user accounts)
- Any passwords or API keys
