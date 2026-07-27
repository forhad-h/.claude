# SmythOS GitHub Repositories

Reference list of all SmythOS repositories for documentation linking. When constructing file links, use the pattern:
`https://github.com/SmythOS/{repo}/blob/main/{path}`

## Repositories

### SmythOS/sre
- **URL**: https://github.com/SmythOS/sre
- **Description**: SmythOS Runtime Engine — core execution engine for agents
- **Key paths**:
  - `packages/core/src/Components/` — runtime components (HuggingFace, OpenAI, etc.)
  - `packages/core/src/` — core engine logic

### SmythOS/smythos-studio
- **URL**: https://github.com/SmythOS/smythos-studio
- **Description**: SmythOS Studio — Electron-based desktop app for building and managing agents
- **Key paths**:
  - `packages/app/src/backend/` — backend services
  - `packages/app/src/backend/services/` — service classes (Cache, Store, HuggingFace, etc.)
  - `packages/app/src/backend/config.ts` — app configuration
  - `packages/app/src/frontend/` — frontend UI

### SmythOS/sre-builder-debugger
- **URL**: https://github.com/SmythOS/sre-builder-debugger
- **Description**: Builder & Debugger tool for SRE workflows
- **Key paths**:
  - `src/` — main source

### SmythOS/sre-embodiment-server
- **URL**: https://github.com/SmythOS/sre-embodiment-server
- **Description**: Embodiment server — handles physical/virtual agent embodiments
- **Key paths**:
  - `src/` — main source

### SmythOS/sre-agent-server
- **URL**: https://github.com/SmythOS/sre-agent-server
- **Description**: Agent server — serves and manages running agents
- **Key paths**:
  - `src/` — main source

## Adding New Repositories

To add a new repository, append an entry following the format above. Include:
- Repository URL
- Brief description
- Key directory paths for documentation linking
