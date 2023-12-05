package main

import (
	"fmt"
	"io"
	"os"
	"strconv"
	"strings"
)

func main() {
	fmt.Println(part1(os.Stdin))
}

func part1(r io.Reader) int {
	input, err := io.ReadAll(r)
	if err != nil {
		panic(err)
	}
	lines := strings.Split(string(input), "\n")
	var sum int
	{
		r, g, b := 12, 13, 14
		for _, line := range lines {
			colonIdx := strings.Index(line, ": ")
			id := atoi(line[len("Game "):colonIdx])
			rest := line[colonIdx+len(": "):]
			sets := strings.Split(rest, "; ")
			valid := true
			for _, set := range sets {
				cubes := strings.Split(set, ", ")
				for _, cube := range cubes {
					n := atoi(strings.Split(cube, " ")[0])
					color := strings.Split(cube, " ")[1]
					if color == "red" && n > r {
						valid = false
						break
					} else if color == "green" && n > g {
						valid = false
						break
					} else if color == "blue" && n > b {
						valid = false
						break
					}
				}
			}
			if valid {
				sum += id
			}
		}
	}
	return sum
}

func atoi(s string) int {
	n, err := strconv.Atoi(s)
	if err != nil {
		panic(err)
	}
	return n
}
