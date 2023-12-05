package main

import (
	"fmt"
	"io"
	"os"
	"strconv"
	"strings"
)

func main() {
	games := parse(os.Stdin)
	fmt.Println(part1(games))
}

type grab struct {
	n     int
	color string
}

func parse(r io.Reader) [][][]grab {
	input, err := io.ReadAll(r)
	if err != nil {
		panic(err)
	}
	lines := strings.Split(string(input), "\n")
	games := make([][][]grab, len(lines))
	for i, line := range lines {
		rest := line[strings.Index(line, ": ")+len(": "):]
		sets := strings.Split(rest, "; ")
		games[i] = make([][]grab, len(sets))
		for j, setstr := range sets {
			cubes := strings.Split(setstr, ", ")
			games[i][j] = make([]grab, len(cubes))
			for k, cube := range cubes {
				var grab grab
				grab.n = atoi(strings.Split(cube, " ")[0])
				grab.color = strings.Split(cube, " ")[1]
				games[i][j][k] = grab
			}
		}
	}
	return games
}

func part1(games [][][]grab) int {
	var sum int
	r, g, b := 12, 13, 14
	for i, game := range games {
		valid := true
		for _, set := range game {
			for _, grab := range set {
				if grab.color == "red" && grab.n > r {
					valid = false
					break
				} else if grab.color == "green" && grab.n > g {
					valid = false
					break
				} else if grab.color == "blue" && grab.n > b {
					valid = false
					break
				}
			}
		}
		if valid {
			sum += i + 1
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
