package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func main() {
	file, _ := os.Open(os.Args[2])
	defer file.Close()
	
	scanner := bufio.NewScanner(file)
	scanner.Split(bufio.ScanLines)

	var count int
	var last int
	for scanner.Scan() {
		cur, _ := strconv.Atoi(scanner.Text())
		if i != 0 && cur > last {
			count++
		}
		last = cur
	}
	fmt.Println("result: " + count)
}
