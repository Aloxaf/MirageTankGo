
CFLAGS=$(shell python-config --cflags)
LDFLAGS=$(shell python-config --ldflags)


CMTCore.so: CMTCore.o
	${CC} -shared CMTCore.o ${LDFLAGS} -o CMTCore.so -s

CMTCore.o: CMTCore.c
	${CC} -c -fPIC ${CFLAGS} CMTCore.c -O3

CMTCore.c: CMTCore.pyx
	cython CMTCore.pyx

.PHONY:clean
clean:
	-rm *.so, *.o, *.c
