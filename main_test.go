package main

import "testing"

func TestAdd(t *testing.T) {
	want := 10
	got := Add(5, 5)
	if want != got {
		t.Fatalf("wanted %d got %d", want, got)
	}
}
