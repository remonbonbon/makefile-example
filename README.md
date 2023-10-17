# makefile-example
Good Makefile for C/C++

## Make

~~~
$ make clean
rm -f ./src/main.o ./src/mod/mod.o app

$ make depend
g++ -I./include -MM ./src/main.cpp ./src/mod/mod.cpp > Makefile.depend

$ make -j4
g++ -O2 -Wall -I./include   -c -o src/main.o src/main.cpp
g++ -O2 -Wall -I./include   -c -o src/mod/mod.o src/mod/mod.cpp
g++ -lm -o app ./src/main.o ./src/mod/mod.o

$ make run
Hello, world!
~~~


## tips

### List of the source files
Use find command in order to list recursively.

~~~
SRCS = $(shell find ./src -type f -name *.cpp)
~~~

### Resolve dependencies by gcc `-MM` option

~~~
$ g++ -I./include -MM ./src/main.cpp ./src/mod/mod.cpp
main.o: src/main.cpp include/main.h include/mod/mod.h
mod.o: src/mod/mod.cpp include/mod/mod.h
~~~

Sadly, outputted rule is only filename.
So, add directory path from first cpp file by sed.

~~~
src/main.o: src/main.cpp include/main.h include/mod/mod.h
src/mod/mod.o: src/mod/mod.cpp include/mod/mod.h
~~~

Makefile includes this result for incremental build.

### Parallel compilation by gcc `-j` option
`-j<max number of parallel job>`

It's better to use the same number as the number of CPU cores.
;If 4 cores, run `make -j4`

This option requires dependency chain in Makefile.
For example, you should run following when clean and build.

~~~
$ make clean -s && make -j4
~~~

