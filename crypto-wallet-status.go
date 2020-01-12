// crypto-wallet-status

package main

import (
	"flag"
	"fmt"
	"os"

	errors "github.com/pkg/errors"
	log "github.com/sirupsen/logrus"
)

const toolVersion = "1.0.1"

var integerPtr *int

// A Function that also returns an error
func jeffFunc(x int) (string, error) {
	if x == 42 {
		// Make your error
		return "error", errors.New("can't work with 42")
	}
	return "Everything worked great", nil
}

// Check your error
func checkErr(err error) {
	if err != nil {
		s := err
		log.Info("MAIN:                        " + s)
		log.Fatal("ERROR:", err)
	}
}

func init() {

	// SET LOG LEVEL
	// log.SetLevel(log.InfoLevel)
	log.SetLevel(log.TraceLevel)

	// SET FORMAT
	log.SetFormatter(&log.TextFormatter{})
	// log.SetFormatter(&log.JSONFormatter{})

	// SET OUTPUT (DEFAULT stderr)
	log.SetOutput(os.Stdout)

	// VERSION FLAG
	version := flag.Bool("v", false, "prints current version")
	// INTEGER FLAG
	integerPtr = flag.Int("i", 42, "This is the flag for an integer")
	// Parse the flags
	flag.Parse()

	// CHECK VERSION
	if *version {
		fmt.Println(toolVersion)
		os.Exit(0)
	}

}

func main() {

	s := "START"
	log.Info("MAIN:                        " + s)

	// DO SOMETHING
	r, err := jeffFunc(*integerPtr)
	checkErr(err)
	log.Info("Returned", r)

	// PRESS RETURN TO EXIT
	s = "PRESS RETURN TO EXIT"
	log.Info("MAIN:                        " + s)
	fmt.Scanln()
	fmt.Printf("\n...DONE\n")

}
