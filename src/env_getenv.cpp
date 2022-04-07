#include "env/member.hpp"
#include "env/list.hpp"
#include "env/env.hpp"

extern char **environ;

const env::list env::getenv() {

	char **s = environ;
	env::list n;

	for (; *s; s++ ) {
		std::string e(*s);
		auto delim = e.find_first_of("=");
		if ( delim == std::string::npos || e.substr(0,delim).empty() || e.substr(delim + 1, e.size() - delim - 1).empty())
			continue;
		n.push(env::member(
				e.substr(0, delim),
				e.substr(delim + 1, e.size() - delim - 1)
		));
	}

	return n;
}
