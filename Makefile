all: test

CXX?=g++
CXXFLAGS?=-std=c++17

INCLUDES=-I./include -I.
LIBS:=

ENV_OBJS:= \
	objs/env_member.o \
	objs/env_list.o \
	objs/env_list_iter.o \
	objs/env_getenv.o

SHELL_OBJS:= \
	objs/shell_exec.o

TEST_OBJS:= \
	objs/test.o

objs/env_member.o: src/env_member.cpp
	$(CXX) $(CXXFLAGS) $(INCLUDES) -c -o $@ $<;

objs/env_list.o: src/env_list.cpp
	$(CXX) $(CXXFLAGS) $(INCLUDES) -c -o $@ $<;

objs/env_list_iter.o: src/env_list_iter.cpp
	$(CXX) $(CXXFLAGS) $(INCLUDES) -c -o $@ $<;

objs/env_getenv.o: src/env_getenv.cpp
	$(CXX) $(CXXFLAGS) $(INCLUDES) -c -o $@ $<;

objs/shell_exec.o: src/shell_exec.cpp
	$(CXX) $(CXXFLAGS) $(INCLUDES) -c -o $@ $<;

objs/test.o: example/test.cpp
	$(CXX) $(CXXFLAGS) $(INCLUDES) -c -o $@ $<;

test: $(ENV_OBJS) $(SHELL_OBJS) $(TEST_OBJS)
	$(CXX) $(CXXFLAGS) $(LDFLAGS) $^ $(LIBS) -o $@;

clean:
	rm -f $(ENV_OBJS) $(SHELL_OBJS) $(TEST_OBJS) test
