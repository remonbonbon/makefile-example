TARGET = app

SRCS  = $(shell find ./src     -type f -name *.cpp)
HEADS = $(shell find ./include -type f -name *.h)
OBJS = $(SRCS:.cpp=.o)
DEPS = Makefile.depend

LIBS = -I./include
CXXFLAGS = -O2 -Wall $(LIBS)


all: $(TARGET)

$(TARGET): $(OBJS) $(HEADS)
	$(CXX) $(CXXFLAGS) -o $@ $(OBJS)

run: all
	@./$(TARGET)

.PHONY: depend clean
depend:
	$(CXX) $(CXXFLAGS) -MM $(SRCS) > $(DEPS)
	@sed -i -E "s/^(.+?).o: ([^ ]+?)\1/\2\1.o: \2\1/g" $(DEPS)
	cat $(DEPS)

clean:
	$(RM) $(OBJS) $(TARGET)

-include $(DEPS)

