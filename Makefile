openvpn:
	go build ./cmd/openvpn

.PHONY: clean
clean:
	rm -f openvpn
	rm -f openvpn.exe
