package main

import (
	"fmt"
	"net"
	"time"
)

func main() {
	ln, err := net.Listen("tcp", ":9999")
	if err != nil {
		panic(err)
	}
	fmt.Println("Word emitter ready on port 9999")

	for {
		conn, err := ln.Accept()
		if err != nil {
			fmt.Println("Connection error:", err)
			continue
		}
		go handleConnection(conn)
	}
}

func handleConnection(conn net.Conn) {
	defer conn.Close()
	fmt.Println("Client connected")

	counter := 1
	for {
		now := time.Now().Format("20060102-150405")
		line := fmt.Sprintf("word%d_%s\n", counter, now)
		_, err := conn.Write([]byte(line))
		if err != nil {
			fmt.Println("Write error:", err)
			return
		}
		fmt.Print("Sent: ", line)
		counter++
		time.Sleep(2 * time.Second)
	}
}
