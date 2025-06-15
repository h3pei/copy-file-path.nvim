# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## プロジェクト概要

copy-file-path.nvimは、Neovimでファイルパスをクリップボードにコピーするためのプラグインです。単体ファイルのパスコピーと、開いている全バッファのパス一括コピーの両方をサポートします。

## アーキテクチャ

### メインファイル: `plugin/copy-file-path.lua`

**コア関数:**
- `format_path(mods, buf_path)`: filename-modifiersを使用したパスフォーマット。第2引数省略時は現在のバッファ
- `copy_to_clipboard(path)`: クリップボードへのコピーとユーザーフィードバック
- `get_all_buffer_paths(mods)`: 全バッファのパスを指定形式で取得
- `copy_all_buffer_paths(mods, opts)`: 全バッファパスの区切り文字処理とコピー
- `parse_separator(separator)`: エスケープ文字（"\n", "\t"）の変換

**コマンド体系:**
- 単体ファイル用: `CopyRelativeFilePath`, `CopyAbsoluteFilePath`, `CopyRelativeFilePathFromHome`, `CopyFileName`
- 全バッファ用: `CopyAllRelativeFilePaths [separator]`, `CopyAllAbsoluteFilePaths [separator]`, `CopyAllRelativeFilePathsFromHome [separator]`, `CopyAllFileNames [separator]`
- すべて`vim.api.nvim_create_user_command`で統一実装

**filename-modifiers:**
- `:p` - 絶対パス
- `:.` - 相対パス  
- `:~` - ホームディレクトリからの相対パス
- `:t` - ファイル名のみ

## 開発コマンド

コードフォーマット:
```bash
stylua .
```

## コーディング規約

- styluaによるLuaコードフォーマット設定: 2スペースインデント、ダブルクォート使用
- 関数には適切な型注釈（`---@param`, `---@return`）を記述
- `vim.api.nvim_create_user_command`でコマンド定義を統一
- 共通処理は関数に抽出して重複を避ける
- エラーハンドリング: バッファが存在しない場合の適切なメッセージ表示