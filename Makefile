GOOS ?= $(shell go env GOOS)
GOARCH ?= $(shell go env GOARCH)
GOARM ?= $(shell go env GOARM)

.PHONY: all
all: openvpn

.PHONY: openvpn
openvpn:
	go build ./cmd/openvpn

.PHONY: dist
dist: openvpn-$(GOOS)-$(GOARCH).tar.gz

.PHONY: dist-all
dist-all: openvpn-linux-amd64.tar.gz
dist-all: openvpn-windows-amd64.zip

openvpn-linux-amd64.tar.gz: GOOS := linux
openvpn-linux-amd64.tar.gz: GOARCH := amd64
openvpn-windows-amd64.zip: GOOS := windows
openvpn-windows-amd64.zip: GOARCH := amd64
openvpn-windows-amd64.zip: EXT := .exe
openvpn-%.tar.gz:
	mkdir -p "dist/openvpn-$*"
	env GOOS=$(GOOS) GOARCH=$(GOARCH) go build -o "dist/openvpn-$*/openvpn$(EXT)" -ldflags "-w -s" ./cmd/openvpn
	cp openvpn.conf "dist/openvpn-$*"
	cd dist && tar czf "$@" "openvpn-$*"

openvpn-%.zip:
	mkdir -p "dist/openvpn-$*"
	env GOOS=$(GOOS) GOARCH=$(GOARCH) go build -o "dist/openvpn-$*/openvpn$(EXT)" -ldflags "-w -s" ./cmd/openvpn
	cp openvpn.conf "dist/openvpn-$*"
	cd dist && zip -r "$@" "openvpn-$*"

.PHONY: clean
clean:
	rm -f openvpn{,.exe}
	rm -rf dist
