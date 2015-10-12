package main

import (
  "fmt"
  "log"
  "regexp"
  "strings"
  "io/ioutil"
)

const workers = 16

func sanitize (input string) string {
  str := strings.ToLower(input)
  reg, _ := regexp.Compile("[^a-z\\s]+")
  str = reg.ReplaceAllString(str, "")
  return str
}

func isPalindrome(text string) bool {
  length := len(text)
  for i := 0; i < length / 2; i += 1 {
    if text[i] != text[length - 1 - i] {
      return false
    }
  }
  return true
}

func getWords() []string {
  bytes, err := ioutil.ReadFile("./words.txt")
  if err != nil {
    log.Fatal(err)
  }

  input := sanitize(string(bytes))
  return strings.Split(input, "\r\n")
}

func Parallel(fn func(int, chan string), times int) ([]chan string) {
  outputs := []chan string{}

  for i := 0; i < times; i += 1 {
    output := make(chan string)
    outputs = append(outputs, output)
    go fn(i, output)
  }
  return outputs
}

func combine(inputs ...chan string) (chan string) {
  output := make(chan string)
  dones := []chan bool{}

  for _, ch := range inputs {
    done := make(chan bool)
    dones = append(dones, done)
    go func(){
      for item := range ch {
        output <- item
      }
      close(done)
    }()
  }

  go func(){
    for _, done := range dones {
      <- done
    }
    close(output)
    fmt.Println("Finished waiting")
  }()

  return output
}

func main () {
  words := getWords()

  // palindromes := combine(Parallel(func(i int, output chan string){
  //   length := len(words)
  //   sectionSize := length / workers
  //   start := sectionSize * i
  //   end := start + sectionSize
  //
  //   if i + 1 == workers {
  //     end += (length - sectionSize * workers)
  //   }
  //
  //   for _, word := range words[start:end] {
  //     for _, otherWord := range words {
  //       if word == otherWord {
  //         continue
  //       }
  //       if isPalindrome(word + otherWord) {
  //         output <- word + " " + otherWord
  //       }
  //     }
  //   }
  //
  //   close(output)
  //   fmt.Printf("Worker %d finished\n", i)
  // }, workers)...)

  // palindromes := []string{}

  length := len(words)
  for i, a := range words {
    counter := i + 1
    for ;counter < length; counter += 1 {
      if isPalindrome(a + words[counter]) {
        fmt.Println(a + " " + words[counter])
      }
    }
  }

  // for p := range palindromes {
  //   fmt.Println(p)
  // }
}
