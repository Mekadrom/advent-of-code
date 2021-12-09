package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func main() {
	fmt.Println("result: " + strconv.Itoa(processInput(readFile(os.Args[2]))))
}

func readFile(path string) []string {
	file, _ := os.Open(path)
	defer file.Close()
	
	scanner := bufio.NewScanner(file)
	scanner.Split(bufio.ScanLines)

	var lines []string
	for scanner.Scan() {
		lines = append(lines, scanner.Text())
	}
	return lines
}


func processInput(inputs []string) (int) {
	var count int
	var last int
	for i, input := range inputs {
		cur, _ := strconv.Atoi(input)
		if i != 0 && cur > last {
			count++
		}
		last = cur
	}
	return count
}
