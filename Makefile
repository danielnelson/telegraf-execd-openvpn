GOOS ?= $(shell go env GOOS)
GOARCH ?= $(shell go env GOARCH)
GOARM ?= $(shell go env GOARM)

.PHONY: all
all: openvpn

openvpn:
	go build ./cmd/openvpn

.PHONY: dist
dist: openvpn-$(GOOS)-$(GOARCH).tar.gz

.PHONY: dist-all
dist-all: openvpn-linux-amd64.tar.gz
dist-all: openvpn-windows-amd64.zip

openvpn-linux-amd64.tar.gz: GOOS := linux
openvpn-linux-amd64.tar.gz: GOARCH := amd64
openvpn-windows-amd64.tar.gz: GOOS := windows
openvpn-windows-amd64.tar.gz: GOARCH := amd64
openvpn-%.tar.gz:
	mkdir -p "dist/openvpn-$*"
	cd "dist/openvpn-$*" && env GOOS=$(GOOS) GOARCH=$(GOARCH) go build -ldflags "-w -s" ../../cmd/openvpn
	cd dist && tar czf "$@" "openvpn-$*"

openvpn-%.zip:
	mkdir -p "dist/openvpn-$*"
	cd "dist/openvpn-$*" && env GOOS=$(GOOS) GOARCH=$(GOARCH) go build -ldflags "-w -s" ../../cmd/openvpn
	cd dist && zip -r "$@" "openvpn-$*"

.PHONY: clean
clean:
	rm -f openvpn{,.exe}
	rm -rf dist
