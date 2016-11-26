
CXX= g++
CC= cc

CFLAGS= -g -O0

%.o: %.cc
	$(CXX) $(CXXFLAGS) $(CFLAGS) -c $< -o $@

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@


EXAMPLES= test-wild-pointer test-double-malloc nice-malloc

test-double-malloc:
	$(CC) test-double-malloc.c -o $@


test-wild-pointer:
	$(CC) test-wild-pointer.c -o $@

nice-malloc:
	$(CC) $@.c -o $@


examples: $(EXAMPLES)

clean:
	-rm -rf *.o
	-rm -rf *.dSYM
	-rm  $(EXAMPLES)