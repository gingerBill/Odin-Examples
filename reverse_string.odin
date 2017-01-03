#import "fmt.odin";
#import "utf8.odin";

main :: proc() {
	MAX :: 64;
	buf:     [MAX]rune;
	backing: [MAX]byte;
	offset:  int;

	msg := "Hello";
	count := utf8.rune_count(msg);
	assert(count <= MAX);
	runes := buf[:count];

	for r, i : msg {
		runes[count-i-1] = r;
	}

	for r : runes {
		data, len := utf8.encode_rune(r);
		copy(backing[offset:], data[:len]);
		offset += len;
	}

	reverse := backing[:offset] as string;
	fmt.println(reverse); // olleH
}
