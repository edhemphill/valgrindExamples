
CXX= g++
CC= cc

%.o: %.cc
	$(CXX) $(CXXFLAGS) $(CFLAGS) -c $< -o $@

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@


test-double-malloc:
	$(CC) test-double-malloc.c -o $@