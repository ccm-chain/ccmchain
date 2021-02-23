# This Makefile is meant to be used by people that do not usually work
# with Go source code. If you know what GOPATH is then you probably
# don't need to bother with make.

.PHONY: gccm android ios gccm-cross evm all test clean
.PHONY: gccm-linux gccm-linux-386 gccm-linux-amd64 gccm-linux-mips64 gccm-linux-mips64le
.PHONY: gccm-linux-arm gccm-linux-arm-5 gccm-linux-arm-6 gccm-linux-arm-7 gccm-linux-arm64
.PHONY: gccm-darwin gccm-darwin-386 gccm-darwin-amd64
.PHONY: gccm-windows gccm-windows-386 gccm-windows-amd64

GOBIN = ./build/bin
GO ?= latest
GORUN = env GO111MODULE=on go run

gccm:
	$(GORUN) build/ci.go install ./cmd/gccm
	@echo "Done building."
	@echo "Run \"$(GOBIN)/gccm\" to launch gccm."

all:
	$(GORUN) build/ci.go install

android:
	$(GORUN) build/ci.go aar --local
	@echo "Done building."
	@echo "Import \"$(GOBIN)/gccm.aar\" to use the library."
	@echo "Import \"$(GOBIN)/gccm-sources.jar\" to add javadocs"
	@echo "For more info see https://stackoverflow.com/questions/20994336/android-studio-how-to-attach-javadoc"

ios:
	$(GORUN) build/ci.go xcode --local
	@echo "Done building."
	@echo "Import \"$(GOBIN)/Gccm.framework\" to use the library."

test: all
	$(GORUN) build/ci.go test

lint: ## Run linters.
	$(GORUN) build/ci.go lint

clean:
	env GO111MODULE=on go clean -cache
	rm -fr build/_workspace/pkg/ $(GOBIN)/*

# The devtools target installs tools required for 'go generate'.
# You need to put $GOBIN (or $GOPATH/bin) in your PATH to use 'go generate'.

devtools:
	env GOBIN= go get -u golang.org/x/tools/cmd/stringer
	env GOBIN= go get -u github.com/kevinburke/go-bindata/go-bindata
	env GOBIN= go get -u github.com/fjl/gencodec
	env GOBIN= go get -u github.com/golang/protobuf/protoc-gen-go
	env GOBIN= go install ./cmd/abigen
	@type "npm" 2> /dev/null || echo 'Please install node.js and npm'
	@type "solc" 2> /dev/null || echo 'Please install solc'
	@type "protoc" 2> /dev/null || echo 'Please install protoc'

# Cross Compilation Targets (xgo)

gccm-cross: gccm-linux gccm-darwin gccm-windows gccm-android gccm-ios
	@echo "Full cross compilation done:"
	@ls -ld $(GOBIN)/gccm-*

gccm-linux: gccm-linux-386 gccm-linux-amd64 gccm-linux-arm gccm-linux-mips64 gccm-linux-mips64le
	@echo "Linux cross compilation done:"
	@ls -ld $(GOBIN)/gccm-linux-*

gccm-linux-386:
	$(GORUN) build/ci.go xgo -- --go=$(GO) --targets=linux/386 -v ./cmd/gccm
	@echo "Linux 386 cross compilation done:"
	@ls -ld $(GOBIN)/gccm-linux-* | grep 386

gccm-linux-amd64:
	$(GORUN) build/ci.go xgo -- --go=$(GO) --targets=linux/amd64 -v ./cmd/gccm
	@echo "Linux amd64 cross compilation done:"
	@ls -ld $(GOBIN)/gccm-linux-* | grep amd64

gccm-linux-arm: gccm-linux-arm-5 gccm-linux-arm-6 gccm-linux-arm-7 gccm-linux-arm64
	@echo "Linux ARM cross compilation done:"
	@ls -ld $(GOBIN)/gccm-linux-* | grep arm

gccm-linux-arm-5:
	$(GORUN) build/ci.go xgo -- --go=$(GO) --targets=linux/arm-5 -v ./cmd/gccm
	@echo "Linux ARMv5 cross compilation done:"
	@ls -ld $(GOBIN)/gccm-linux-* | grep arm-5

gccm-linux-arm-6:
	$(GORUN) build/ci.go xgo -- --go=$(GO) --targets=linux/arm-6 -v ./cmd/gccm
	@echo "Linux ARMv6 cross compilation done:"
	@ls -ld $(GOBIN)/gccm-linux-* | grep arm-6

gccm-linux-arm-7:
	$(GORUN) build/ci.go xgo -- --go=$(GO) --targets=linux/arm-7 -v ./cmd/gccm
	@echo "Linux ARMv7 cross compilation done:"
	@ls -ld $(GOBIN)/gccm-linux-* | grep arm-7

gccm-linux-arm64:
	$(GORUN) build/ci.go xgo -- --go=$(GO) --targets=linux/arm64 -v ./cmd/gccm
	@echo "Linux ARM64 cross compilation done:"
	@ls -ld $(GOBIN)/gccm-linux-* | grep arm64

gccm-linux-mips:
	$(GORUN) build/ci.go xgo -- --go=$(GO) --targets=linux/mips --ldflags '-extldflags "-static"' -v ./cmd/gccm
	@echo "Linux MIPS cross compilation done:"
	@ls -ld $(GOBIN)/gccm-linux-* | grep mips

gccm-linux-mipsle:
	$(GORUN) build/ci.go xgo -- --go=$(GO) --targets=linux/mipsle --ldflags '-extldflags "-static"' -v ./cmd/gccm
	@echo "Linux MIPSle cross compilation done:"
	@ls -ld $(GOBIN)/gccm-linux-* | grep mipsle

gccm-linux-mips64:
	$(GORUN) build/ci.go xgo -- --go=$(GO) --targets=linux/mips64 --ldflags '-extldflags "-static"' -v ./cmd/gccm
	@echo "Linux MIPS64 cross compilation done:"
	@ls -ld $(GOBIN)/gccm-linux-* | grep mips64

gccm-linux-mips64le:
	$(GORUN) build/ci.go xgo -- --go=$(GO) --targets=linux/mips64le --ldflags '-extldflags "-static"' -v ./cmd/gccm
	@echo "Linux MIPS64le cross compilation done:"
	@ls -ld $(GOBIN)/gccm-linux-* | grep mips64le

gccm-darwin: gccm-darwin-386 gccm-darwin-amd64
	@echo "Darwin cross compilation done:"
	@ls -ld $(GOBIN)/gccm-darwin-*

gccm-darwin-386:
	$(GORUN) build/ci.go xgo -- --go=$(GO) --targets=darwin/386 -v ./cmd/gccm
	@echo "Darwin 386 cross compilation done:"
	@ls -ld $(GOBIN)/gccm-darwin-* | grep 386

gccm-darwin-amd64:
	$(GORUN) build/ci.go xgo -- --go=$(GO) --targets=darwin/amd64 -v ./cmd/gccm
	@echo "Darwin amd64 cross compilation done:"
	@ls -ld $(GOBIN)/gccm-darwin-* | grep amd64

gccm-windows: gccm-windows-386 gccm-windows-amd64
	@echo "Windows cross compilation done:"
	@ls -ld $(GOBIN)/gccm-windows-*

gccm-windows-386:
	$(GORUN) build/ci.go xgo -- --go=$(GO) --targets=windows/386 -v ./cmd/gccm
	@echo "Windows 386 cross compilation done:"
	@ls -ld $(GOBIN)/gccm-windows-* | grep 386

gccm-windows-amd64:
	$(GORUN) build/ci.go xgo -- --go=$(GO) --targets=windows/amd64 -v ./cmd/gccm
	@echo "Windows amd64 cross compilation done:"
	@ls -ld $(GOBIN)/gccm-windows-* | grep amd64
