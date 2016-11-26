
CXX= g++
CC= cc

CFLAGS= -g -O0

%.o: %.cc
	$(CXX) $(CXXFLAGS) $(CFLAGS) -c $< -o $@

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@


EXAMPLES= test-wild-pointer test-double-malloc nice-malloc

examples: $(EXAMPLES)

test-double-malloc:
	$(CC) $(CFLAGS) test-double-malloc.c -o $@


test-wild-pointer:
	$(CC) $(CFLAGS) test-wild-pointer.c -o $@

nice-malloc:
	$(CC) $(CFLAGS) $@.c -o $@



clean:
	-rm -rf *.o
	-rm -rf *.dSYM
	-rm  $(EXAMPLES)