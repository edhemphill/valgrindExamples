
valgrind examples for OS X


#### Prerequisites
* Ensure XCode is installed
* Install XCode command line tools: `xcode-select --install`

#### Build valgrind
After checking out the repo, go into the root dir of the repo and run the `build.sh` script:

```
smellytooth2:valgrindExamples ed$ ./build.sh
```

#### Running examples

First, make the examples:
```
smellytooth2:valgrindExamples ed$ make examples
```



#### Possible requirements
In some cases you may need autotools:
* Install Homebrew, run this on the terminal: `ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
* At the terminal: `brew install autotools` and `brew install automake` 
