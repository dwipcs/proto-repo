PROTO_DIR=.
OUT_DIR=generated

proto:
	@echo "🚀 Generating gRPC code..."
	@go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
	@go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
	@protoc -I=$(PROTO_DIR) --go_out=$(OUT_DIR) --go-grpc_out=$(OUT_DIR) --go-grpc_opt=require_unimplemented_servers=false $(PROTO_DIR)/auth/v1/auth_service.proto $(PROTO_DIR)/auth/v1/auth_messages.proto $(PROTO_DIR)/common/v1/common_messages.proto $(PROTO_DIR)/common/v1/common_enums.proto

clean:
	@echo "🧹 Cleaning generated files..."
	@powershell -Command "Remove-Item -Recurse -Force $(OUT_DIR)/*"

