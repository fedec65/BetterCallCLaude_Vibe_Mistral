# BetterCallCLaude for Vibe

A port of the BetterCallClaude legal intelligence framework for use with Vibe. This repository adapts the original framework to work with Vibe's tools and capabilities.

---

## 🚀 Installation

### Prerequisites
- **Node.js**: Required for MCP servers.
- **Python 3.8+**: Required for command scripts.
- **Vibe**: The coding agent that will orchestrate the framework.

### Steps

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/fedec65/BetterCallCLaude_Vibe_Mistral.git
   cd BetterCallCLaude_Vibe_Mistral
   ```

2. **Run the Setup Script**:
   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```
   This will:
   - Install Node.js dependencies for MCP servers.
   - Install Python dependencies for command scripts.
   - Set up the configuration directory.

3. **Configure the Framework**:
   Edit `config/config.yaml` to set your preferences:
   ```yaml
   privacy_mode: balanced      # strict | balanced | cloud
   llm_backend: anthropic      # anthropic | ollama
   canton_focus: ["ZH", "GE"]  # Prioritize these courts
   languages: ["de", "en"]     # Output preferences
   ```

---

## 📋 Usage

### Starting MCP Servers
MCP servers must be started before running commands. Use the helper script:

```bash
# Start all MCP servers
./scripts/start_mcp.sh
```

Or start individual servers:
```bash
cd mcp-servers/bge-search && npm start &
cd mcp-servers/entscheidsuche && npm start &
```

### Running Commands
Commands are executed via Vibe's `bash` tool. Example:

```python
# Run a legal research command
result = bash("command": "./commands/legal_research.sh --query 'BGE 147 V 321'")
```

Available commands:
- `legal_research.sh`: Search legal sources.
- `legal_strategy.sh`: Case strategy analysis.
- `legal_draft.sh`: Document drafting.
- `legal_cite.sh`: Verify citations.

### Loading Personas
Personas are loaded dynamically using Vibe's `read_file` tool:

```python
# Load a persona definition
researcher = read_file(path="personas/Legal_Researcher.md")
```

Available personas:
- `Legal_Researcher.md`: Legal research specialist.
- `Case_Strategist.md`: Litigation strategy expert.
- `Legal_Drafter.md`: Document drafting specialist.

### Stopping MCP Servers
Use the helper script to stop all MCP servers:

```bash
./scripts/stop_mcp.sh
```

---

## 🎯 Architecture

### Commands
Commands are shell/Python scripts that replace BetterCallClaude's slash commands. Each command:
- Takes arguments (e.g., `--query`, `--jurisdiction`).
- Communicates with MCP servers.
- Returns structured output.

### MCP Servers
MCP servers are Node.js processes that expose legal data via JSON-RPC. Servers include:
- `bge-search`: Federal Supreme Court database.
- `entscheidsuche`: Swiss court decision database.
- `legal-citations`: Citation verification and formatting.

### Personas
Personas are markdown files defining expert agents. Each persona includes:
- A prompt template.
- Expertise areas.
- MCP server dependencies.

### Configuration
User settings are stored in `config/config.yaml`. Supported options:
- `privacy_mode`: Control data privacy (strict, balanced, cloud).
- `llm_backend`: Choose LLM provider (anthropic, ollama).
- `canton_focus`: Prioritize specific cantons.
- `languages`: Set output languages.

---

## 📂 Directory Structure

```
BetterCallCLaude_Vibe_Mistral/
├── commands/          # Command scripts
│   ├── legal_research.sh
│   ├── legal_strategy.sh
│   ├── legal_draft.sh
│   └── legal_cite.sh
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
└── README.md          # Documentation
```

---

## 🔧 Development

### Adding New Commands
1. Create a new script in `commands/` (e.g., `new_command.sh`).
2. Ensure it follows the argument format (e.g., `--query`, `--jurisdiction`).
3. Document the command in `README.md`.

### Adding New Personas
1. Create a new markdown file in `personas/` (e.g., `New_Persona.md`).
2. Define the persona's prompt template and expertise areas.
3. Update `README.md` to list the new persona.

### Extending MCP Servers
1. Add new MCP server code to `mcp-servers/`.
2. Update `scripts/start_mcp.sh` to start the new server.
3. Document the server in `README.md`.

---

## 📜 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## 🤝 Contributing

Contributions are welcome! Please open an issue or submit a pull request.

---

## ⚠️ Disclaimer

**BetterCallCLaude for Vibe is a legal intelligence tool, not a lawyer.**
All outputs require professional review. Users maintain full responsibility for all work products generated using this framework.
