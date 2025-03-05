# ブランチ保護の設定

このリポジトリでは、以下のブランチ保護ルールを設定することを推奨します。GitHubのリポジトリの「Settings」→「Branches」→「Branch protection rules」で設定できます。

## 保護対象ブランチ

以下のブランチに対して保護ルールを設定することを推奨します：

- `main` (または `master`)
- `develop`

## 推奨ルール

### main/masterブランチ

- **Require pull request reviews before merging**: 有効化
  - **Required approving reviews**: 1名以上
  - **Dismiss stale pull request approvals when new commits are pushed**: 有効化
  - **Require review from Code Owners**: 有効化

- **Require status checks to pass before merging**: 有効化
  - **Require branches to be up to date before merging**: 有効化
  - **必須ステータスチェック**:
    - `Test` (go-test.yml)
    - `Lint` (go-lint.yml)
    - `Validate PR` (pr-validation.yml)

- **Require signed commits**: 有効化（オプション）

- **Require linear history**: 有効化（オプション）

- **Do not allow bypassing the above settings**: 有効化

### developブランチ

- **Require pull request reviews before merging**: 有効化
  - **Required approving reviews**: 1名以上

- **Require status checks to pass before merging**: 有効化
  - **Require branches to be up to date before merging**: 有効化
  - **必須ステータスチェック**:
    - `Test` (go-test.yml)
    - `Lint` (go-lint.yml)

## ブランチ命名規則

以下のブランチ命名規則に従うことを推奨します：

- 機能追加: `feature/機能名`
- バグ修正: `fix/問題名`
- リファクタリング: `refactor/対象名`
- ドキュメント: `docs/対象名`
- リリース: `release/バージョン`
