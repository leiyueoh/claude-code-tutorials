#!/bin/bash

# Claude Code Tutorials 同步脚本
# 功能：从 Obsidian 同步到 projects 目录，然后推送到 GitHub

set -e

# 配置
SOURCE_DIR="/mnt/c/Users/leiyu/Documents/Obsidian/Obsidian Personal/a-claude code"
TARGET_DIR="/home/leiyu/projects/claude-code-tutorials"

echo "🔄 开始同步 Claude Code Tutorials..."

# 1. 从 Obsidian 同步到 projects 目录（不删除本地独有的文件）
echo "📥 从 Obsidian 同步文件..."
rsync -av \
  --exclude='.git' \
  --exclude='sync.sh' \
  --exclude='README.md' \
  "$SOURCE_DIR/" "$TARGET_DIR/"

cd "$TARGET_DIR"

# 2. 检查是否有变更
if git diff --quiet && git diff --cached --quiet; then
    echo "✅ 没有检测到变更，无需同步"
    exit 0
fi

# 3. 提交变更
echo "📝 提交变更..."
git add -A
git commit -m "Sync from Obsidian: $(date '+%Y-%m-%d %H:%M:%S')"

# 4. 推送到 GitHub
echo "🚀 推送到 GitHub..."
git push origin master

echo "✅ 同步完成！"
echo "📦 GitHub 仓库: https://github.com/leiyueoh/claude-code-tutorials"
