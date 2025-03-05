# ビルドステージ
FROM golang:1.21-alpine AS builder

# 必要なパッケージをインストール
RUN apk add --no-cache gcc g++ make git

# 作業ディレクトリ設定
WORKDIR /go/src/app

# モジュールをダウンロード
COPY go.mod go.sum ./
RUN go mod download

# ソースコードをコピー
COPY . .

# アプリケーションをビルド
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /go/bin/app ./cmd/api

# 実行ステージ
FROM alpine:3.18

RUN apk add --no-cache ca-certificates tzdata

# タイムゾーンを設定
ENV TZ=Asia/Tokyo

# ビルドしたアプリケーションをコピー
COPY --from=builder /go/bin/app /app

# 非rootユーザーを作成
RUN adduser -D -H -h /app appuser
USER appuser

# ポートを公開
EXPOSE 8080
EXPOSE 50051

# アプリケーションを実行
CMD ["/app"]
