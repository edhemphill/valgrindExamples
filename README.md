
valgrind examples for OS X


#### Prerequisites
* Ensure XCode is installed
* Install XCode command line tools: `xcode-select --install`

#### Build valgrind
After checking out the repo, go into the root dir of the repo and run the `build.sh` script:

```
smellytooth2:valgrindExamples ed$ ./build.sh
```

The `valgrind` executable will now be in `valgrindExamples/build/bin` - the header files will be in `valgrindExamples/build/include`

#### Running examples

First, make the examples:
```
smellytooth2:valgrindExamples ed$ make examples
```

#### Examples
The base line is `nice-malloc`. Running this still produces a lot of noise when your run it with `valgrind --leak-check=full`, that's because, not suprisingly, many base libraries don't clean up their memory correctly. In practice, there is not really anything wrong with this. If there is no way or reason the process will later need to reclaim that memory, then it's fine for the process to just bomb out with no `free()` call. When the process exits all the memory allocated to it by the OS will get `free()`'d anyway. Another reason for the noise is that some libraries allocate memory or play tricks on the stack pointer (SP in x86 assembly) which the valgrind has no way of understanding.

The technique is to typically get a baseline program, which you *know* has no leaks, and then compare this output to something which might. `nice-malloc` will be our base.

```
smellytooth2:valgrindExamples ed$ build/bin/valgrind --leak-check=full ./nice-malloc
==71508== Memcheck, a memory error detector
==71508== Copyright (C) 2002-2015, and GNU GPL'd, by Julian Seward et al.
==71508== Using Valgrind-3.13.0.SVN and LibVEX; rerun with -h for copyright info
==71508== Command: ./nice-malloc
==71508==
==71508==
==71508== HEAP SUMMARY:
==71508==     in use at exit: 22,229 bytes in 189 blocks
==71508==   total heap usage: 272 allocs, 83 frees, 28,425 bytes allocated
==71508==
==71508== 64 bytes in 1 blocks are definitely lost in loss record 27 of 64
==71508==    at 0x100008307: calloc (vg_replace_malloc.c:714)
...
```
The remaining lines preceeding show memory potential leaks. Notice that the `calloc` leak is coming out of `vg_replace_malloc` which has nothing to do with the code in the example. So, this is an *expected leak.*

No we can run the example with obvious leaks. Try `test-double-malloc`:

```
smellytooth2:valgrindExamples ed$ build/bin/valgrind --leak-check=full ./test-double-malloc
==71523== Memcheck, a memory error detector
==71523== Copyright (C) 2002-2015, and GNU GPL'd, by Julian Seward et al.
==71523== Using Valgrind-3.13.0.SVN and LibVEX; rerun with -h for copyright info
==71523== Command: ./test-double-malloc
==71523==
==71523==
==71523== HEAP SUMMARY:
==71523==     in use at exit: 22,264 bytes in 191 blocks
==71523==   total heap usage: 274 allocs, 83 frees, 28,452 bytes allocated
==71523==
==71523== 16 bytes in 1 blocks are definitely lost in loss record 4 of 66
==71523==    at 0x100007931: malloc (vg_replace_malloc.c:302)
==71523==    by 0x100000F73: main (in ./test-double-malloc)
==71523==
==71523== 19 bytes in 1 blocks are definitely lost in loss record 5 of 66
==71523==    at 0x100007931: malloc (vg_replace_malloc.c:302)
==71523==    by 0x100000F4A: main (in ./test-double-malloc)
==71523==
==71523== 64 bytes in 1 blocks are definitely lost in loss record 29 of 66   <------- this was in our baseline program, ignore it
==71523==    at 0x100008307: calloc (vg_replace_malloc.c:714)
==71523==    by 0x1004F2231: NXMapGet (in /usr/lib/libobjc.A.dylib)
...
```
The 16 and 19 bytes show up as obvious leaks.


#### Possible requirements
In some cases you may need autotools:
* Install Homebrew, run this on the terminal: `ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
* At the terminal: `brew install autotools` and `brew install automake` 

#### Notes
The valgrind dev team made some fixes in October to fix builds on OS X 10.11 and 10.12. If you get an error for `undefined symbols` concerning `__zero` it's becuase you are probably not on the most recent code. I pulled this valgrind straight from their `master` branch on Nov 26. Changes were checked Oct 23. https://sourceforge.net/p/valgrind/mailman/message/35445907/
