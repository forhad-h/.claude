---
name: linkedin-post
description: Writes a human-sounding, high-engagement LinkedIn post from a rough note or idea. Use when the user asks to write, draft, or rework a LinkedIn post.
allowed-tools: Read, Write, Bash, WebSearch, WebFetch
---

# LinkedIn post writer

Turn a rough input into one finished post that reads like a person wrote it, earns comments, and holds up in front of recruiters.

Two failure modes this skill exists to prevent:

1. **The AI tell.** Em dashes, "It's not X, it's Y", triplets, symmetric paragraphs, tidy closing lessons. Readers now spot these instantly.
2. **The skill's own pattern.** If every post follows the same recipe, that recipe becomes the new tell by post five. Hence the roll in Step 2, which is binding.

---

## Step 1 — Read the input, don't interview

Write directly if the input already contains a **specific moment**: a real bug, a real number, a real thing that broke.

Ask at most **2 questions**, and only for missing hard specifics:
- the actual number, the actual error text, the actual tool or version
- what it cost (hours, money, tokens)
- the moment it turned, if the story has one

Never ask about audience, tone, style, or length. That is what the roll decides.

Never invent a specific to fill a gap. One wrong detail costs the whole post's credibility.

---

## Step 2 — Roll the recipe

```bash
bash "${CLAUDE_SKILL_DIR}/scripts/roll.sh"
```

Returns `MODE`, `OPENING`, `LENGTH`, `RHYTHM`, `CLOSING`, `TEXTURE` (2 markers), `ESL`, `FALLBACK`.

**The roll is binding.** Do not re-roll because a different mode feels better. Variance across the set is worth more than the local optimum of one post.

Override only when the input genuinely cannot support the mode (for example `before-after` with no numbers in the input). Take the first `FALLBACK` mode and state which and why in one line.

If the input contains `rough 1` or `rough 3`, that overrides the ESL default (see `voice.md`).

---

## Step 3 — Read the references

- `${CLAUDE_SKILL_DIR}/references/voice.md` — always
- `${CLAUDE_SKILL_DIR}/references/modes.md` — the rolled mode's section only
- `${CLAUDE_SKILL_DIR}/references/humanize.md` — always
- `${CLAUDE_SKILL_DIR}/references/hooks.md` — when writing the opening and the alt first lines

---

## Step 4 — Write

**One idea per post.** The test: a reader must be able to repeat the point in one sentence. If it takes two sentences, there are two ideas. Cut the weaker one.

Highest value, fewest words:
- Every sentence must add information or emotion. Sentences that only transition get deleted.
- Specifics beat adjectives. `4.2s → 900ms` beats "much faster". `ECONNRESET` beats "a network issue".
- Show the moment, do not summarize it.
- Cut the first paragraph after writing. Usually it was a warm-up.

Obey the rolled `LENGTH`, `RHYTHM`, `CLOSING`, exactly two `TEXTURE` markers, and exactly one `ESL` marker (unless `none`).

---

## Step 5 — Self-check

Run all seven before output. Revise on any failure.

1. **One idea?** State the point in one sentence. If you cannot, cut.
2. **Blacklist scan.** Search for `—`, "It's not X", three-item lists, and every banned phrase in `humanize.md` Part A. Any hit, rewrite that line.
3. **Hook test.** Read only the first 210 characters. Would a stranger tap "see more"?
4. **Value test.** Does the reader leave with something usable, or only with a feeling about the author? Only a feeling means the post fails.
5. **Roll compliance.** Mode, length band, rhythm, closing type, 2 texture markers, 1 ESL marker.
6. **Read-aloud test.** Any sentence that cannot be said in one breath gets split or cut.
7. **Symmetry check.** If paragraph lengths form a neat pattern, break one.

---

## Step 6 — Output

```
--- POST ---
<the post, ready to paste, nothing else>

--- ALT FIRST LINES ---
1. <different opening type>
2. <different opening type>
3. <different opening type>

--- NOTES ---
Mode: <mode> · <n> words · <n> chars before "see more"
First comment: <URL, or "none">
```

Then log it:

```bash
echo "$(date +%F) | <mode> | <opening>" >> "${CLAUDE_SKILL_DIR}/history.log"
```

The log is what keeps the next three posts from repeating this shape. Always write it.

Keep commentary outside the blocks to one or two lines at most. The user wants the post, not an explanation of the post.

---

## Step 7 — Iteration

On feedback, change only the specific thing named. Do not rewrite the whole post. Do not re-roll unless asked.

If the user says it still sounds like AI, the fix is almost always one of: a surviving em dash, a paragraph rhythm that is too even, or a closing line that generalizes. Check those three first.
