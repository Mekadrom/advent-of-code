package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

const ONE byte = 49

var gamma int64
var epsilon int64

func main() {
	calcGammaAndEpsilon(parse(readFile(os.Args[2])))
	fmt.Println("result: " + strconv.Itoa(int(gamma * epsilon)))
}

func parse(inputs []string) [][]bool {
	var parsed [][]bool
	for _, input := range inputs {
		bArr := []byte(input)
		// fmt.Printf("%v\n", bArr)
		var boolArr []bool
		for _, b := range bArr {
			boolArr = append(boolArr, b == ONE)
		}
		parsed = append(parsed, boolArr)
	}
	fmt.Printf("%v\n", parsed)
	return parsed
}

func readFile(path string) []string {
	file, _ := os.Open(path)
	defer file.Close()
	
	scanner := bufio.NewScanner(file)
	scanner.Split(bufio.ScanLines)

	var inputs []string
	for scanner.Scan() {
		inputs = append(inputs, scanner.Text())
	}
	return inputs
}

func calcGammaAndEpsilon(nums [][]bool) {
	var numOnes []int
	for i := 0; i < len(nums[0]); i++ {
		numOnes = append(numOnes, 0)
	}

	for _, b := range nums {
		for i := 0; i < len(b); i++ {
			if b[i] {
				numOnes[i] += 1
			}
		}
	}

	var gammaRep string
	var epsilonRep string
	for _, num := range numOnes {
		if num > len(nums) - num {
			gammaRep += "0"
			epsilonRep += "1"
		} else {
			gammaRep += "1"
			epsilonRep += "0"
		}
	}

	gamma, _ = strconv.ParseInt(gammaRep, 2, 32)
	epsilon, _ = strconv.ParseInt(epsilonRep, 2, 32)
}
