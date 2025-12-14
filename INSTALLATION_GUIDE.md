# Installation Guide for BetterCallCLaude_Vibe_Mistral

This guide provides step-by-step instructions for installing and using BetterCallCLaude_Vibe_Mistral.

---

## 📋 Prerequisites

Before installing, ensure you have the following:

1. **Node.js** (v14 or later)
   - Required for MCP servers.
   - Download: [https://nodejs.org](https://nodejs.org)

2. **Python 3.8+**
   - Required for command scripts.
   - Download: [https://www.python.org](https://www.python.org)

3. **Vibe**
   - The coding agent that will orchestrate the framework.

4. **Git**
   - Required to clone the repository.
   - Download: [https://git-scm.com](https://git-scm.com)

---

## 🚀 Installation Steps

### 1. Clone the Repository

```bash
git clone https://github.com/fedec65/BetterCallCLaude_Vibe_Mistral.git
cd BetterCallCLaude_Vibe_Mistral
```

### 2. Run the Setup Script

```bash
chmod +x setup.sh
./setup.sh
```

The setup script will:
- Create the directory structure.
- Install Node.js dependencies for MCP servers.
- Install Python dependencies for command scripts.
- Create a default configuration file.
- Create helper scripts for managing MCP servers.

### 3. Configure the Framework

Edit the configuration file to set your preferences:

```bash
nano config/config.yaml
```

Example configuration:

```yaml
# BetterCallCLaude for Vibe - Configuration

privacy_mode: balanced      # strict | balanced | cloud
llm_backend: anthropic      # anthropic | ollama
canton_focus: ["ZH", "GE"]  # Prioritize these courts
languages: ["de", "en"]     # Output preferences
mcp_servers:
  bge_search:
    enabled: true
  entscheidsuche:
    enabled: true
  legal_citations:
    enabled: true
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

| Command | Description |
|---------|-------------|
| `legal_research.sh` | Search legal sources |
| `legal_strategy.sh` | Case strategy analysis |
| `legal_draft.sh` | Document drafting |

### Loading Personas

Personas are loaded dynamically using Vibe's `read_file` tool:

```python
# Load a persona definition
researcher = read_file(path="personas/Legal_Researcher.md")
```

Available personas:

| Persona | Description |
|---------|-------------|
| `Legal_Researcher.md` | Legal research specialist |
| `Case_Strategist.md` | Litigation strategy expert |
| `Legal_Drafter.md` | Document drafting specialist |

### Stopping MCP Servers

Use the helper script to stop all MCP servers:

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
├── PORTING_SUMMARY.md # Porting summary
└── INSTALLATION_GUIDE.md # This file
```

---

## 🛠️ Troubleshooting

### MCP Servers Not Starting
- Ensure Node.js is installed.
- Check for errors in the MCP server logs.
- Verify that the required ports are available.

### Commands Not Working
- Ensure MCP servers are running.
- Check that the command scripts are executable (`chmod +x commands/*.sh`).
- Verify that the required arguments are provided.

### Configuration Issues
- Ensure `config/config.yaml` is valid YAML.
- Verify that the specified MCP servers are enabled.

---

## 📜 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## 🤝 Support

For issues or questions, please open an issue on GitHub:
[https://github.com/fedec65/BetterCallCLaude_Vibe_Mistral/issues](https://github.com/fedec65/BetterCallCLaude_Vibe_Mistral/issues)
