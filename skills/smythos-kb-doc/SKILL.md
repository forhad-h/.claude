---
name: smythos-kb-doc
description: Generates BookStack-formatted HTML documentation for SmythOS knowledge base projects.
disable-model-invocation: true
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, Agent, WebSearch, WebFetch
---

# SmythOS Knowledge Base Doc Writer

You are writing a documentation page for the SmythOS internal knowledge base, which runs on BookStack. Follow this workflow precisely.

## Step 1: Gather Information

Before writing anything, ask the user the following questions (skip any already answered in the conversation):

1. **What is this doc page about?** (feature, architecture, integration, debugging guide, etc.)
2. **Which SmythOS project(s) does it relate to?** (sre, smythos-studio, sre-builder-debugger, sre-embodiment-server, sre-agent-server)
3. **Who is the audience?** (new developers, senior engineers, DevOps, all team members)
4. **What is the Page Title?** (plain text, no formatting)
5. **Any specific sections or topics to cover?**
6. **Any known issues, gotchas, or callouts to include?**

Wait for user responses before proceeding.

## Step 2: Research

Based on user answers:

1. **Read the GitHub repos reference** file at `${CLAUDE_SKILL_DIR}/references/github-repos.md` to get project URLs and structure hints
2. **Explore the relevant codebase** — use Agent (Explore type) or Grep/Glob to find the actual source files, classes, functions, and patterns related to the topic
3. **Search the web** if the topic involves external concepts (APIs, protocols, libraries) that need accurate technical details
4. **Verify code references** — any file path or function you mention MUST exist in the repo. Use the GitHub repo URLs from the reference file to construct links. For private repos, guess the file path by combining the repo URL + typical project structure patterns you discover
5. If anything is unclear or contradictory, ask the user for clarification before proceeding

## Step 3: Write the Documentation

Use the BookStack HTML template at `${CLAUDE_SKILL_DIR}/references/bookstack-template.html` as your formatting reference.

### Formatting Rules

- **Page Title**: Plain text only, no HTML formatting. Pass it as a separate clearly labeled section above the content
- **Content**: Full BookStack HTML
- Every `<p>`, `<h2>`, `<h3>`, `<pre>`, `<table>`, `<ul>`, `<ol>`, `<hr>` element MUST have a unique `id="bkmrk-..."` attribute (use a slugified snippet of the content)
- **External links**: ALL `<a>` tags pointing outside the KB MUST have `target="_blank" rel="noopener noreferrer"`
- **Code blocks**: Use `<pre id="bkmrk-..."><code class="language-{lang}">...</code></pre>` with appropriate language class
- **Callout boxes**: Use `<p class="callout info">` for info and `<p class="callout warning">` for warnings
- **Tables**: Use full `<table>` with `<thead>` and `<tbody>`
- **Horizontal rules**: `<hr id="bkmrk-...">` to separate major sections
- **Source file references**: Link to GitHub with the exact file path, e.g. `<a href="https://github.com/SmythOS/repo/blob/main/path/to/file.ts" target="_blank" rel="noopener noreferrer"><code>file.ts</code></a>`

### Content Guidelines

- Write so both humans and AI models can easily parse and understand the content
- Lead with a callout box summarizing what the page covers
- Use clear hierarchical headings (h2 for major sections, h3 for subsections)
- Include code examples with real function names and real file paths from the codebase
- Add ASCII diagrams for data flows or architecture where helpful
- Include a "Source Files" table at the end listing all referenced files with their purpose
- Add "Related" callout at the bottom linking to related KB pages if applicable
- Keep paragraphs concise — prefer tables and lists over long prose
- Use `<strong>` for key terms on first use, `<code>` for code identifiers inline

## Step 4: Output

1. Create the output directory:
   ```
   mkdir -p /tmp/smythos-kb-docs
   ```

2. Write the file to `/tmp/smythos-kb-docs/<page-title-slug>.html` where the slug is the page title lowercased with spaces replaced by hyphens

3. The file should have this structure:
   ```
   <!-- Page Title: {Plain text title here} -->
   
   {BookStack HTML content here}
   ```

## Step 5: Notify Completion

Run the notification script:
```bash
bash "${CLAUDE_SKILL_DIR}/scripts/notify.sh"
```

Then tell the user:
- The file location
- A brief summary of what was documented
- Ask if they want to review, make changes, or if you should remove the file when they're done

## Step 6: Iteration

If the user says something is wrong:
1. Acknowledge the correction
2. Fix the specific issue in the file
3. Explain what was changed
4. Re-run the notification script

If the user asks to remove the file:
```bash
rm -rf /tmp/smythos-kb-docs/<the-file>
```

Ask if they want to remove the entire `/tmp/smythos-kb-docs/` directory.
