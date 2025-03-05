# ContentAI バックエンド

ContentAIアプリケーションのバックエンド実装です。Go言語によるRESTful APIを提供します。

## プロジェクト構造

```
backend/
├── cmd/                # アプリケーションのエントリーポイント
│   └── api/            # APIサーバーのエントリーポイント
├── configs/            # 設定ファイル
├── internal/           # 非公開パッケージ（アプリケーション固有のコード）
│   └── recommendation/ # 推薦サービスの実装
├── pkg/                # 公開パッケージ（他のプロジェクトで再利用可能なコード）
```

## 開発環境セットアップ

```bash
# 依存関係のインストール
go mod download

# 開発用サーバーの起動
go run cmd/api/main.go

# テストの実行
go test ./...

# リントの実行
golangci-lint run
```

## CI/CD

このプロジェクトは以下のGitHub Actionsワークフローを使用しています：

- **go-test.yml**: Goのテスト実行とカバレッジレポート生成（70%以上必須）
- **go-lint.yml**: golangci-lintを使用したコード品質チェック
- **pr-validation.yml**: PRが作成された際の検証ワークフロー

## コントリビューションガイド

1. 開発用ブランチを作成（`feature/機能名` または `fix/問題名`）
2. 変更を実装し、テストを追加
3. コードをリントし、テストが通ることを確認
4. PR作成時にテンプレートに従って情報を入力
5. レビュー後にマージ

詳細なブランチ保護設定については `BRANCH_PROTECTION.md` を参照してください。
