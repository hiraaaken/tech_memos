#!/bin/bash

# 設定
# REPO_DIR: 技術メモのリポジトリのディレクトリ
REPO_DIR="任意のディレクトリ"
TEMPLATE_FILE="tech_memo.md"
NEXT_MONTH=$(date -v+1m "+%Y-%m")
TARGET_DIR="$REPO_DIR/$NEXT_MONTH"
TARGET_FILE="$TARGET_DIR/$TEMPLATE_FILE"

# フォルダの作成
mkdir -p "$TARGET_DIR"

echo ${NEXT_MONTH}

# テンプレート作成
echo "# 技術メモ - ${NEXT_MONTH//-年/-}" > "$TARGET_FILE"
for i in $(seq 1 $(cal "$NEXT_MONTH" | awk 'NF {DAYS = $NF}; END {print DAYS}')); do
  printf "\n## %d\n### 学習内容\n### メモ\n### 気づき\n### 課題\n" "$i" >> "$TARGET_FILE"
done

# GitHubへ自動コミット & プッシュ
cd "$REPO_DIR"
git add "$TARGET_FILE"
git commit -m "Add new tech memo template for $NEXT_MONTH"
git push origin main

# 完了メッセージ
echo "Tech memo template for $NEXT_MONTH has been created successfully."