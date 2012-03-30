/*
 * Copyright (C) 2012, xp@renzhi.ca
 * All rights reserved.
 */

package main

import (
	"foo"
	"fmt"
)

func main() {
	i := 4
	fmt.Printf("foo=%d, bar=%d\n", foo.Foo(i), foo.Bar(i))
}