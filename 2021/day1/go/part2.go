package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func main() {
	fmt.Println("result: " + strconv.Itoa(processInput(squishWindow(readFile(os.Args[2]), 3))))
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

func squishWindow(inputs []string, windowSize int) ([]int) {
	var ints []int
	for i := 0; i < len(inputs); i++ {
		var sum int
		if i + windowSize <= len(inputs) {
			for j := 0; j < windowSize; j++ {
				num, _ := strconv.Atoi(inputs[i+j])
				sum += num
			}
		}
		ints = append(ints, sum)
	}
	return ints
}

func processInput(inputs []int) (int) {
	var count int
	var last int
	for i, cur := range inputs {
		if i != 0 && cur > last {
			count++
		}
		last = cur
		}
	return count
}
