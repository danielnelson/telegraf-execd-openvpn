package main

import (
	"flag"
	"fmt"
	"os"

	"github.com/influxdata/telegraf"
	"github.com/influxdata/telegraf/plugins/common/shim"
	"github.com/influxdata/telegraf/plugins/inputs/openvpn"
)

var configFile = flag.String("config", "", "path to the config file for this plugin")
var usage = flag.Bool("usage", false, "print sample configuration")

func printConfig(name string, p telegraf.PluginDescriber) {
	fmt.Printf("# %s\n", p.Description())
	fmt.Printf("[[inputs.%s]]", name)

	config := p.SampleConfig()
	if config != "" {
		fmt.Printf(config)
	} else {
		fmt.Printf("\n  # no configuration\n")
	}
}

func main() {
	flag.Parse()

	if *usage {
		printConfig("openvpn", &openvpn.OpenVPN{})

		os.Exit(0)
	}

	shim := shim.New()

	err := shim.LoadConfig(configFile)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Err loading input: %v\n", err)
		os.Exit(1)
	}

	if err := shim.Run(0); err != nil {
		fmt.Fprintf(os.Stderr, "Err: %v\n", err)
		os.Exit(1)
	}
}
