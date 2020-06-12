OpenVPN Plugin for Telegraf execd input
---
![](https://github.com/danielnelson/telegraf-execd-plugins/workflows/Build/badge.svg)


## Usage

- Download the [latest release package][release] for your platform.

- Unpack the build to your system:
  ```sh
  mkdir /var/lib/telegraf
  chown telegraf:telegraf /var/lib/telegraf
  tar xf openvpn-linux-amd64.tar.gz -C /var/lib/telegraf
  ```

- Edit execd plugin configuration as needed:
  ```sh
  vi /var/lib/telegraf/openvpn-linux-amd64/openvpn.conf
  ```

- Add to `/etc/telegraf/telegraf.conf` or into file in `/etc/telegraf/telegraf.d`
  ```toml
  [[inputs.execd]]
    command = ["/var/lib/telegraf/openvpn-linux-amd64/openvpn --config /var/lib/telegraf/openvpn-linux-amd64/openvpn.conf"]
    signal = "STDIN"
  ```

- Restart or reload Telegraf.

## Development

When updating the plugin the replace directive in `go.mod` will need updated.

Generally it is expected that no tag will exist and the plugin will reside in a branch.
```sh
go mod edit -replace github.com/influxdata/telegraf=github.com/danielnelson/telegraf@openvpn-input
go mod tidy
```


[releases]: https://github.com/danielnelson/telegraf-execd-openvpn/releases/latest
