.PHONY: all build clean test lint fmt proto mock run docker-build docker-run docker-stop help

# 変数定義
APP_NAME := contentai
BUILD_DIR := build
PROTO_DIR := api
GO_FILES := $(shell find . -name "*.go" -not -path "./vendor/*" -not -path "./$(BUILD_DIR)/*")
PROTO_FILES := $(shell find $(PROTO_DIR) -name "*.proto")
VERSION := $(shell git describe --tags --always --dirty)
LDFLAGS := -ldflags="-X 'main.Version=$(VERSION)'"

# デフォルトターゲット
all: clean fmt lint test build

# ビルド
build:
	@echo "Building $(APP_NAME)..."
	@mkdir -p $(BUILD_DIR)
	@go build $(LDFLAGS) -o $(BUILD_DIR)/$(APP_NAME) ./cmd/api

# クリーンアップ
clean:
	@echo "Cleaning..."
	@rm -rf $(BUILD_DIR)
	@go clean -i ./...
	@go clean -testcache

# テスト実行
test:
	@echo "Running tests..."
	@go test -race -cover ./...

# コードカバレッジレポート生成
coverage:
	@echo "Generating coverage report..."
	@go test -race -coverprofile=coverage.out ./...
	@go tool cover -html=coverage.out -o coverage.html
	@echo "Coverage report generated: coverage.html"

# lint実行
lint:
	@echo "Running linter..."
	@if ! command -v golangci-lint &> /dev/null; then \
		echo "golangci-lint is not installed. Installing..."; \
		go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest; \
	fi
	@golangci-lint run ./...

# コードフォーマット
fmt:
	@echo "Formatting code..."
	@gofmt -s -w $(GO_FILES)

# Protocol Buffers からのコード生成
proto:
	@echo "Generating code from protobuf..."
	@if ! command -v protoc &> /dev/null; then \
		echo "protoc is not installed. Please install it manually."; \
		exit 1; \
	fi
	@if ! command -v protoc-gen-go &> /dev/null; then \
		echo "protoc-gen-go is not installed. Installing..."; \
		go install google.golang.org/protobuf/cmd/protoc-gen-go@latest; \
	fi
	@if ! command -v protoc-gen-go-grpc &> /dev/null; then \
		echo "protoc-gen-go-grpc is not installed. Installing..."; \
		go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest; \
	fi
	@for file in $(PROTO_FILES); do \
		protoc --go_out=. --go_opt=paths=source_relative \
			--go-grpc_out=. --go-grpc_opt=paths=source_relative \
			$$file; \
	done

# モック生成
mock:
	@echo "Generating mocks..."
	@if ! command -v mockgen &> /dev/null; then \
		echo "mockgen is not installed. Installing..."; \
		go install github.com/golang/mock/mockgen@latest; \
	fi
	@go generate ./...

# アプリケーション実行
run:
	@echo "Running application..."
	@go run ./cmd/api

# Docker ビルド
docker-build:
	@echo "Building Docker image..."
	@docker build -t $(APP_NAME):$(VERSION) .

# Docker 実行
docker-run:
	@echo "Running Docker container..."
	@docker-compose up -d

# Docker 停止
docker-stop:
	@echo "Stopping Docker container..."
	@docker-compose down

# 依存関係のクリーンアップと整理
deps-clean:
	@echo "Cleaning up dependencies..."
	@go mod tidy

# ヘルプ
help:
	@echo "Available commands:"
	@echo "  make          : Build the application after running tests and linters"
	@echo "  make build    : Build the application"
	@echo "  make clean    : Remove build artifacts and clean Go cache"
	@echo "  make test     : Run tests"
	@echo "  make coverage : Generate test coverage report"
	@echo "  make lint     : Run linter"
	@echo "  make fmt      : Format code"
	@echo "  make proto    : Generate code from Protocol Buffers"
	@echo "  make mock     : Generate mocks for testing"
	@echo "  make run      : Run the application"
	@echo "  make docker-build : Build Docker image"
	@echo "  make docker-run   : Run application in Docker"
	@echo "  make docker-stop  : Stop Docker container"
	@echo "  make deps-clean   : Clean up dependencies"
	@echo "  make help     : Show this help message"
