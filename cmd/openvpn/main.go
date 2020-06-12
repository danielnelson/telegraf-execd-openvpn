package main

import (
	"flag"
	"fmt"
	"os"
	"time"

	"github.com/influxdata/telegraf/plugins/inputs/execd/shim"
	_ "github.com/influxdata/telegraf/plugins/inputs/openvpn"
)

var configFile = flag.String("config", "", "path to the config file for this plugin")

func main() {
	flag.Parse()

	shim := shim.New()

	err := shim.LoadConfig(configFile)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Err loading input: %v\n", err)
		os.Exit(1)
	}

	if err := shim.Run(time.Second); err != nil {
		fmt.Fprintf(os.Stderr, "Err: %v\n", err)
		os.Exit(1)
	}
}
