#!/bin/bash

# check_deps.sh
# 检测 init-topic-vault skill 所需的 Claude Code plugin 依赖
# exit 0：所有依赖就绪，走完整流程
# exit 1：有依赖缺失，走降级流程

CLAUDE_PLUGINS_DIR="$HOME/.claude/plugins"
MISSING=0

check_plugin() {
  local plugin_name=$1
  local plugin_dir="$CLAUDE_PLUGINS_DIR/$plugin_name"
  local cache_dir_official="$CLAUDE_PLUGINS_DIR/cache/claude-plugins-official/$plugin_name"
  local cache_dir_agent="$CLAUDE_PLUGINS_DIR/cache/anthropic-agent-skills"

  if [ -d "$plugin_dir" ] || [ -d "$cache_dir_official" ] || ls "$cache_dir_agent"/*/"$plugin_name" 2>/dev/null | grep -q .; then
    echo "✓ $plugin_name"
  else
    echo "✗ $plugin_name 未找到"
    MISSING=1
  fi
}

check_plugin "superpowers"
check_plugin "obsidian"

if [ "$MISSING" -eq 0 ]; then
  echo "all_deps_ok"
  exit 0
else
  echo "deps_missing"
  exit 1
fi
