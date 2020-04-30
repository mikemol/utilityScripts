#!/bin/bash

function tagline {
	tag=${1} ; shift
	line=${1}
	printf '%s: %s: %s\n' "$(date)" "${tag}" "${line}"
}

function tagstream {
	tag=${1} ; shift
	while IFS= read -r line; do
		tagline "${tag}" "${line}"
	done
}

# Hey, anyone that sees this. Any way to flush stderr and stdout before
# exiting this script _without_ wrapping the whole thing up with stdbuf?
( eval "$@" ) 2> >( >&2 tagstream "STDERR" ) > >( tagstream "STDOUT" )
exit $? # Redundant until I accidentally add anything below this...

