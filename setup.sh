#!/bin/bash

# BetterCallCLaude for Vibe - Setup Script
# This script installs dependencies and sets up the framework.

echo "🚀 Setting up BetterCallCLaude for Vibe..."

# Create directories if they don't exist
mkdir -p commands
mkdir -p mcp-servers
mkdir -p personas
mkdir -p config
mkdir -p scripts

echo "✅ Created directory structure."

# Install Node.js dependencies for MCP servers
if [ -d "mcp-servers/bge-search" ]; then
    echo "📦 Installing dependencies for bge-search..."
    cd mcp-servers/bge-search && npm install
    cd ../..
fi

if [ -d "mcp-servers/entscheidsuche" ]; then
    echo "📦 Installing dependencies for entscheidsuche..."
    cd mcp-servers/entscheidsuche && npm install
    cd ../..
fi

if [ -d "mcp-servers/legal-citations" ]; then
    echo "📦 Installing dependencies for legal-citations..."
    cd mcp-servers/legal-citations && npm install
    cd ../..
fi

echo "✅ Installed Node.js dependencies."

# Install Python dependencies for command scripts
if [ -f "requirements.txt" ]; then
    echo "🐍 Installing Python dependencies..."
    pip install -r requirements.txt
    echo "✅ Installed Python dependencies."
else
    echo "⚠️  No requirements.txt found. Skipping Python dependencies."
fi

# Create default configuration
if [ ! -f "config/config.yaml" ]; then
    echo "📝 Creating default configuration..."
    cat > config/config.yaml <<EOL
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
EOL
    echo "✅ Created default configuration."
fi

# Create helper scripts
if [ ! -f "scripts/start_mcp.sh" ]; then
    echo "🛠️  Creating start_mcp.sh..."
    cat > scripts/start_mcp.sh <<EOL
#!/bin/bash
# Start all MCP servers

echo "Starting MCP servers..."

if [ -d "mcp-servers/bge-search" ]; then
    echo "Starting bge-search..."
    cd mcp-servers/bge-search && npm start &
    cd ../..
fi

if [ -d "mcp-servers/entscheidsuche" ]; then
    echo "Starting entscheidsuche..."
    cd mcp-servers/entscheidsuche && npm start &
    cd ../..
fi

if [ -d "mcp-servers/legal-citations" ]; then
    echo "Starting legal-citations..."
    cd mcp-servers/legal-citations && npm start &
    cd ../..
fi

echo "✅ All MCP servers started."
EOL
    chmod +x scripts/start_mcp.sh
    echo "✅ Created start_mcp.sh."
fi

if [ ! -f "scripts/stop_mcp.sh" ]; then
    echo "🛠️  Creating stop_mcp.sh..."
    cat > scripts/stop_mcp.sh <<EOL
#!/bin/bash
# Stop all MCP servers

echo "Stopping MCP servers..."

# Find and kill Node.js processes running MCP servers
pids=$(ps aux | grep -E "mcp-servers/(bge-search|entscheidsuche|legal-citations)" | grep -v grep | awk '{print $2}')

if [ -z "$pids" ]; then
    echo "No MCP servers running."
else
    echo "Killing MCP server processes..."
    kill $pids
    echo "✅ All MCP servers stopped."
fi
EOL
    chmod +x scripts/stop_mcp.sh
    echo "✅ Created stop_mcp.sh."
fi

echo ""
echo "🎉 Setup complete!"
echo ""
echo "Next steps:"
echo "1. Start MCP servers: ./scripts/start_mcp.sh"
echo "2. Run commands in Vibe using the bash tool."
echo "3. Load personas using the read_file tool."
