package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func main() {
	chunkSize, _ := strconv.Atoi(os.Args[3])
	file, _ := os.Open(os.Args[2])
	defer file.Close()
	
	scanner := bufio.NewScanner(file)
	scanner.Split(bufio.ScanLines)

	var i int
	var count int
	var last int
	var cur int
	var inputs []int
	for scanner.Scan() {
		num, _ := strconv.Atoi(scanner.Text())
		cur += num
		inputs = append(inputs, num)
		if i >= chunkSize {
			cur -= inputs[i - chunkSize]
			if cur > last {
				count++
			}
			last = cur
		}
		i++
	}
	fmt.Println("result: " + strconv.Itoa(count))
}
