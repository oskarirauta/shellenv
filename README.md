# shellenv

shellenv is a C++ helper for exec and shell environment get/manipulation.

It exposes 2 classes and 3 methods/functions (actually 4, if you count a string manipulator which strips whitespaces from both ends of std::string).
Classes are in env:: namespace, they are
 - env::member
 - env::list


### classes

env::list is a container similar to std::map<std::string, std::string> except, it's locked for key and value types; as storage it uses a linked list
with smart pointers. Key is always std::string and value is always env::member which pretty much just contains key and value as a string. Key cannot be
altered after it is set, but value (std::string) can be changed anytime and setting it to empty, will erase key from container.

Use of env::list is pretty simple, it has only few methods:

 - erase(std::string& key)
 - bool empty()
 - size_t size()
 - clear()

but methods are not that necessary, as you can use it with just by subscripts..

```
env::list l;
l["hello"] = "world"; // key hello is now world
["hello"] = ""; // key hello (and it's value world) is erased (size will be 0 now as it was only key in list)
```

list's can be combined, or altered on-the-fly, check example.
You can even forward it's contents to output stream.

env::member can be populated with (std::string key, std::string value) constructor.

### methods

 - env::list env::getenv()
 - int shell::exec(std::string& cmd, std::string& args = "", env::list& shell_env = env::list());
 - pid_t shell::execf(std::string& cmd, std::string& args = "", env::list& shell_env = env::list());
 - std::string env::trimmed(std::string &s)

env::getenv() returns env::list with current shell environment.
shell::exec executes with given parameters, either execv or execvpe (or if -DOSX given in CXXFLAGS, execve) depending on shell_env is set to empty
env::list or not. Result int is given on case of error.
shell::execf does the same thing, except executes forked and results with pid_t of forked process.
env::trimmed trims whitespace from both ends of string and is commonly used within shellenv
