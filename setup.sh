#!/bin/sh
# Connect FOMO Bot's Parallel tools to Cline. Composio runs through its CLI (`composio login`).
# Usage: cp .env.example .env, fill it in, then ./setup.sh
set -eu
[ -f .env ] && . ./.env
: "${PARALLEL_API_KEY:?set PARALLEL_API_KEY in .env}"

cline mcp add parallel-search https://search.parallel.ai/mcp --transport http --yes
cline mcp add parallel-task https://task-mcp.parallel.ai/mcp --transport http \
  --header "Authorization: Bearer $PARALLEL_API_KEY" --yes
echo "Done. Run 'cline mcp' to check both Parallel servers are enabled."
