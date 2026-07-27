# .claude

Extending Claude Code's agentic capabilities through personal configuration, workflows, and integrations.

This repository contains shared [Claude Code](https://docs.anthropic.com/en/docs/claude-code) skills and configurations meant to be cloned into `~/.claude/`.

## Skills

### smythos-kb-doc

Generates BookStack-formatted HTML documentation pages for the SmythOS internal knowledge base.

**What it does:**

1. Gathers context — asks about the topic, target project, and audience
2. Researches the relevant SmythOS codebase using included repo references
3. Writes a fully formatted BookStack HTML page with proper `bkmrk-` IDs, code blocks, tables, and source file links
4. Outputs the HTML to `/tmp/smythos-kb-docs/` and plays an audio notification on completion

**Files:**

| File | Purpose |
|------|---------|
| `SKILL.md` | Skill definition and step-by-step workflow |
| `assets/kb-doc-complete.mp3` | Completion notification audio |
| `references/github-repos.md` | SmythOS repository URLs and key paths |
| `references/bookstack-template.html` | BookStack HTML formatting reference |
| `scripts/notify.sh` | Cross-platform audio playback (Linux, macOS, Windows) |

**Usage:**

```
/smythos-kb-doc
```

## Setup

Clone this repo as your `~/.claude` directory (back up any existing config first):

```bash
# Back up existing config
mv ~/.claude ~/.claude.bak

# Clone
git clone <repo-url> ~/.claude

# Restore any personal config files from backup
cp ~/.claude.bak/settings.json ~/.claude/
cp ~/.claude.bak/settings.local.json ~/.claude/
```

Or selectively copy the skills directory into your existing `~/.claude/`:

```bash
cp -r <repo>/skills/ ~/.claude/skills/
```
