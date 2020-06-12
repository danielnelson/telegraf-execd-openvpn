GOOS ?= $(shell go env GOOS)
GOARCH ?= $(shell go env GOARCH)
GOARM ?= $(shell go env GOARM)

.PHONY: all
all: openvpn

openvpn:
	go build ./plugins/inputs/openvpn

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
	env GOOS=$(GOOS) GOARCH=$(GOARCH) go build -o "dist/openvpn-$*/openvpn" -ldflags "-w -s" ./plugins/inputs/openvpn
	mkdir -p "dist/openvpn-$*"
	tar czf "$@" -C dist "openvpn-$*"

openvpn-%.zip:
	env GOOS=$(GOOS) GOARCH=$(GOARCH) go build -o "dist/openvpn-$*/openvpn" -ldflags "-w -s" ./plugins/inputs/openvpn
	mkdir -p "dist/openvpn-$*"
	(cd dist && zip  -r - "openvpn-$*") > "$@"

.PHONY: clean
clean:
	rm -f openvpn{,.exe}
	rm -rf dist
	rm -f *.tar.gz
	rm -f *.zip
