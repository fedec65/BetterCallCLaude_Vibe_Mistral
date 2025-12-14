# Porting Summary: BetterCallClaude to Vibe

This document summarizes the porting of BetterCallClaude from Claude Code to Vibe.

---

## 📋 Overview

### Original Framework (BetterCallClaude)
- **Platform**: Claude Code (native integration)
- **Commands**: Slash commands (e.g., `/legal:research`)
- **Agents**: Dynamic persona activation
- **MCP Servers**: Auto-started, JSON-RPC integration
- **Configuration**: Integrated with Claude Code settings

### Ported Framework (BetterCallCLaude_Vibe_Mistral)
- **Platform**: Vibe (script-based integration)
- **Commands**: Shell/Python scripts (e.g., `legal_research.sh`)
- **Agents**: Manual persona loading via `read_file`
- **MCP Servers**: Manual start/stop via scripts
- **Configuration**: Local `config.yaml` file

---

## 🔧 Key Adaptations

### 1. Commands
**Original**: Native slash commands in Claude Code.
**Ported**: Shell scripts in `commands/` directory.

| Original Command | Ported Script |
|------------------|---------------|
| `/legal:research` | `commands/legal_research.sh` |
| `/legal:strategy` | `commands/legal_strategy.sh` |
| `/legal:draft` | `commands/legal_draft.sh` |

### 2. Agents (Personas)
**Original**: Dynamic activation via `PersonaActivator`.
**Ported**: Manual loading via `read_file`.

| Original Persona | Ported File |
|------------------|-------------|
| Legal Researcher | `personas/Legal_Researcher.md` |
| Case Strategist | `personas/Case_Strategist.md` |
| Legal Drafter | `personas/Legal_Drafter.md` |

### 3. MCP Servers
**Original**: Auto-started, integrated via JSON-RPC.
**Ported**: Manual start/stop via scripts.

| Original Server | Ported Location |
|-----------------|-----------------|
| `bge-search` | `mcp-servers/bge-search/` |
| `entscheidsuche` | `mcp-servers/entscheidsuche/` |
| `legal-citations` | `mcp-servers/legal-citations/` |

### 4. Configuration
**Original**: `~/.betterask/config.yaml` (integrated).
**Ported**: `config/config.yaml` (local).

---

## 🛠️ Usage in Vibe

### Starting MCP Servers
```bash
# Start all MCP servers
./scripts/start_mcp.sh
```

### Running Commands
```python
# Run a legal research command
result = bash("command": "./commands/legal_research.sh --query 'BGE 147 V 321'")
```

### Loading Personas
```python
# Load a persona definition
researcher = read_file(path="personas/Legal_Researcher.md")
```

### Stopping MCP Servers
```bash
./scripts/stop_mcp.sh
```

---

## 📂 Directory Structure

```
BetterCallCLaude_Vibe_Mistral/
├── commands/          # Command scripts
│   ├── legal_research.sh
│   ├── legal_strategy.sh
│   └── legal_draft.sh
├── mcp-servers/       # MCP server code
│   ├── bge-search/
│   ├── entscheidsuche/
│   └── legal-citations/
├── personas/          # Persona definitions
│   ├── Legal_Researcher.md
│   ├── Case_Strategist.md
│   └── Legal_Drafter.md
├── config/            # Configuration files
│   └── config.yaml
├── scripts/           # Helper scripts
│   ├── start_mcp.sh
│   └── stop_mcp.sh
├── setup.sh           # Installation script
├── README.md          # Documentation
├── PORTING_SUMMARY.md # This file
└── LICENSE            # MIT License
```

---

## 📝 Notes

### Limitations
1. **No Native Slash Commands**: Vibe uses scripts instead of native slash commands.
2. **Manual MCP Management**: MCP servers must be started/stopped manually.
3. **No Dynamic Persona Activation**: Personas are loaded manually.

### Advantages
1. **Modularity**: Easy to extend with new commands, personas, or MCP servers.
2. **Transparency**: Scripts are easy to debug and modify.
3. **Portability**: Works with any Vibe instance.

---

## 🔮 Future Improvements

1. **Automate MCP Server Management**: Use Vibe to start/stop MCP servers dynamically.
2. **Enhance Command Parsing**: Add support for more complex arguments.
3. **Integrate Local LLMs**: Support Ollama for privacy-focused workflows.
4. **Add More Personas**: Extend the persona ecosystem (e.g., Compliance Officer).

---

## 📜 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
