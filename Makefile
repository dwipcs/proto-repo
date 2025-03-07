SRC_DIR=.
DST_DIR=./generated
GAPI_DIR=./third-party/googleapis
GATEWAY_DIR=./third-party/grpc-gateway

# Target to install necessary protoc plugins
install_proto_tools:
	@echo Installing necessary protoc plugins
	@go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
	@go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
	@go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway@latest
	@go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2@latest

# Target to generate proto files for product writer microservice
proto: install_proto_tools
	@echo Generating code from service proto
	protoc \
	-I=$(SRC_DIR) -I=$(GAPI_DIR) -I=$(GATEWAY_DIR) \
	--go_out=$(DST_DIR) \
	--go-grpc_out=$(DST_DIR) \
	--go-grpc_opt=require_unimplemented_servers=false \
	auth/v1/*_service.proto

# Target to generate proto files for product writer messages microservice
proto_message: install_proto_tools
	@echo Generating code from messages proto
	protoc \
	-I=$(SRC_DIR)/product \
	--go_out=$(DST_DIR) \
	--go-grpc_out=$(DST_DIR) \
	--go-grpc_opt=require_unimplemented_servers=false \
	auth/v1/*.proto