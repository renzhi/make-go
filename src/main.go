/*
 * Copyright (C) 2012, xp@renzhi.ca
 * All rights reserved.
 */

package main

import (
	"hello"
	"foo"
	"fmt"
)

func main() {
	fmt.Printf("Hello world\n");
	fmt.Printf("%s, %s\n", hello.Hello(), hello.World())

	i := 4;
	fmt.Printf("foo=%d, bar=%d\n", foo.Foo(i), foo.Bar(i))

}
