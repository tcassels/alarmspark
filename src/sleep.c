void sleep(int time) {
	time = time * 100000000;
	int c = 0;
	while (c <= time) {
                ++c;
        }
}
