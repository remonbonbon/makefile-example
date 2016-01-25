# makefile-example
Good Makefile for C/C++

## Make

~~~
$ make clean
rm -f ./src/main.o ./src/mod/mod.o app

$ make depend
g++ -O2 -Wall -I./include -MM ./src/main.cpp ./src/mod/mod.cpp > Makefile.depend
cat Makefile.depend
src/main.o: src/main.cpp include/main.h include/mod/mod.h
src/mod/mod.o: src/mod/mod.cpp include/mod/mod.h

$ make
g++ -O2 -Wall -I./include   -c -o src/main.o src/main.cpp
g++ -O2 -Wall -I./include   -c -o src/mod/mod.o src/mod/mod.cpp
g++ -O2 -Wall -I./include -o app ./src/main.o ./src/mod/mod.o

$ make run
Hello, world!
~~~


## tips

### List the source files
Use find command in order to list recursively.

~~~
SRCS = $(shell find ./src -type f -name *.cpp)
~~~

### Resolve dependencies by gcc `-MM` option

~~~
$ gcc -I./include -MM ./src/main.cpp ./src/mod/mod.cpp
main.o: src/main.cpp include/main.h include/mod/mod.h
mod.o: src/mod/mod.cpp include/mod/mod.h
~~~

Sadly, outputted rule is only filename.
So, add directory path from first cpp file by sed.

~~~
src/main.o: src/main.cpp include/main.h include/mod/mod.h
src/mod/mod.o: src/mod/mod.cpp include/mod/mod.h
~~~

Makefile includes this for incremental build.
