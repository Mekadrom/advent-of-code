package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

type command struct {
	direction string
	length int
}

func newCommand(direction string, length int) command {
	return command{direction, length}
}

type pos struct {
	x int
	y int
}

func (p pos) calcDist() int {
	return p.x * p.y
}

func main() {
	fmt.Println("result: " + strconv.Itoa(walkCommands(readFile(os.Args[2])).calcDist()))
}

func readFile(path string) []command {
	file, _ := os.Open(path)
	defer file.Close()
	
	scanner := bufio.NewScanner(file)
	scanner.Split(bufio.ScanLines)

	var commands []command
	for scanner.Scan() {
		commandStrArr := strings.Fields(scanner.Text())
		length, _ := strconv.Atoi(commandStrArr[1])
		commands = append(commands, command{commandStrArr[0], length})
	}
	return commands
}

func walkCommands(commands []command) pos {
	p := pos{}
	for _, command := range commands {
		switch command.direction {
			case "forward": p.x += command.length
			case "up": p.y -= command.length
			case "down": p.y += command.length
			default: fmt.Println("Unknown direction: " + command.direction)
		}
	}
	return p
}
