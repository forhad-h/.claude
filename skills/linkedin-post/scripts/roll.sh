#!/usr/bin/env bash
# Rolls the recipe for one LinkedIn post.
# Real entropy, because a model asked to "pick randomly" keeps picking the same things.
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
HIST="$DIR/history.log"
touch "$HIST"

MODES=(war-story teardown contrarian metaphor field-notes beginner-mind before-after micro-essay question-first build-log)
OPENINGS=(cold-number mid-scene flat-confession counterintuitive genuine-question blunt-sentence real-quote small-image)
LENGTHS=(micro short short medium medium medium long)   # weighted toward short/medium
RHYTHMS=(staccato mixed mixed one-block-then-short list-ish)
CLOSINGS=(open-question flat-stop unresolved-loop small-confession one-line-takeaway)
TEXTURES=(
  "fragment sentences"
  "start a sentence with And/But/So"
  "self-interrupt and correct yourself"
  "mix a spelled-out number with a digit"
  "use ... mid-thought"
  "keep one filler word (actually / basically / honestly / I mean)"
  "one sentence much longer than its neighbours"
  "a concrete detail that serves no purpose (cold tea, the clock, the rain)"
  "name a real tool, version, or error string"
  "an aside in parentheses"
  "repeat a word for emphasis"
  "trail off without finishing the thought"
  "admit you still do not fully understand it"
  "contradict yourself slightly and leave it"
)
ESL=(
  "drop an article (\"I opened terminal\", \"worst part is\")"
  "present perfect where simple past belongs (\"I have read that line 20 times\")"
  "slightly-off collocation (\"stuck in this problem\", \"searching the reason\")"
  "direct-translation phrasing (\"after that I have understood one thing\")"
  "redundant subject or a doubled that"
  "none"
)

pick() { local -n a=$1; echo "${a[$((RANDOM % ${#a[@]}))]}"; }

# Exclude the last 3 modes so a week of posts never repeats a shape.
recent=$(tail -n 3 "$HIST" 2>/dev/null | cut -d'|' -f2 | tr -d ' ' || true)
pool=()
for m in "${MODES[@]}"; do
  grep -qx "$m" <<<"$recent" || pool+=("$m")
done
[ ${#pool[@]} -eq 0 ] && pool=("${MODES[@]}")

MODE="${pool[$((RANDOM % ${#pool[@]}))]}"

# Two distinct textures.
t1=$((RANDOM % ${#TEXTURES[@]}))
t2=$t1; while [ "$t2" = "$t1" ]; do t2=$((RANDOM % ${#TEXTURES[@]})); done

# Fallback modes, in case the input cannot support the rolled one.
fallback=()
for m in "${pool[@]}"; do [ "$m" != "$MODE" ] && fallback+=("$m"); done

cat <<EOF
MODE:      $MODE
OPENING:   $(pick OPENINGS)
LENGTH:    $(pick LENGTHS)
RHYTHM:    $(pick RHYTHMS)
CLOSING:   $(pick CLOSINGS)
TEXTURE:   ${TEXTURES[$t1]} + ${TEXTURES[$t2]}
ESL:       ${ESL[$((RANDOM % ${#ESL[@]}))]}
FALLBACK:  ${fallback[0]:-teardown}, ${fallback[1]:-field-notes}
EOF
