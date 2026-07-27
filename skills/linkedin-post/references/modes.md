# Modes

Read only the section the roll selected. Each mode is a different shape, not a different topic.

---

## war-story

A bug or incident, told in order, as it happened.

- **Shape:** the moment it broke → what you thought it was → what it actually was → what it cost you.
- **Fits:** any debugging session with a real surprise in the middle.
- **Opener:** `The logs said the tool call succeeded. The database said nothing had happened.`
- **Goes wrong when:** you explain before you show. Start inside the problem, not before it.

---

## teardown

How one thing actually works underneath.

- **Shape:** the thing most people assume → what is really going on → one concrete example → why it matters in practice.
- **Fits:** a mechanism you had to learn properly to fix something.
- **Opener:** `An LLM does not "call" your function. It writes a string and hopes you are listening.`
- **Goes wrong when:** it turns into documentation. Keep one mechanism, one example, stop.

---

## contrarian

A mild, defensible disagreement with common advice.

- **Shape:** the advice → why it is popular (steelman it honestly) → where it breaks → what you do instead.
- **Fits:** when you have actually paid the cost of following the advice.
- **Opener:** `"Just add more context" is the most expensive advice in agent building.`
- **Goes wrong when:** the steelman is missing. Without it you sound like a contrarian bot, and the comments turn hostile instead of curious.

---

## metaphor

A technical idea explained through an ordinary image. Forhad's literary lane.

- **Shape:** the image first → the technical thing → carry the image through to the end.
- **Fits:** an abstract idea that resists a diagram (context windows, retries, state, race conditions).
- **Opener:** `A context window is like a small table. You can put anything on it, but not everything.`
- **Goes wrong when:** you switch images halfway, or the image is prettier than it is useful. One image. All the way.

---

## field-notes

Raw observations from this week's work. Unpolished on purpose.

- **Shape:** 3 to 5 loose observations, no intro, no conclusion, no numbering that implies a system.
- **Fits:** a week with several small learnings and no single big one.
- **Opener:** `Things I noticed this week while wiring up tool calls.`
- **Goes wrong when:** the notes get polished into a listicle. Let them stay uneven. One can be a single word.

---

## beginner-mind

Something you did not know until very recently, taught in the same breath as admitting it.

- **Shape:** the admission → the thing itself → why nobody told you → who else probably does not know.
- **Fits:** anything you were slightly embarrassed not to know.
- **Opener:** `Until Tuesday I thought retries were free.`
- **Goes wrong when:** the vulnerability is performed. If you were not actually surprised, use a different mode.

---

## before-after

A number-driven change, with receipts. **Requires real numbers.** If the input has none, fall back.

- **Shape:** the before number → the one thing you changed → the after number → the part that did not improve.
- **Fits:** latency, cost, token counts, build times, error rates.
- **Opener:** `4.2 seconds down to 900ms. The fix was deleting code.`
- **Goes wrong when:** every number improves. Include the one that did not, or nobody believes any of them.

---

## micro-essay

60 to 90 words. One sharp thought. No CTA, no lesson, no question.

- **Shape:** a single idea, turned once, then stopped.
- **Fits:** an opinion or observation that gets weaker the more you explain it.
- **Opener:** `Most agent bugs are not model bugs. They are trust bugs.`
- **Goes wrong when:** you add a closing line to be safe. The abrupt stop is the whole effect. Trust it.

---

## question-first

Opens with a real open question. Highest comment yield of any mode.

- **Shape:** the question → why you are asking (a real situation) → your own partial answer → hand it back.
- **Fits:** a genuine unresolved tradeoff in your current work.
- **Opener:** `How do you decide when an agent should stop retrying?`
- **Goes wrong when:** the question is rhetorical and you already have the full answer. Readers feel the setup and refuse to play along. You must actually not know.

---

## build-log

What shipped, what broke, what is next.

- **Shape:** shipped this → broke here → doing this next. Short, factual, unsentimental.
- **Fits:** a week of visible progress on a project.
- **Opener:** `Shipped the retry layer. Immediately found out retries were making the bug worse.`
- **Goes wrong when:** it reads like a changelog. There has to be one moment in it where something surprised you.
