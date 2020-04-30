# utilityScripts

A handful of useful script snippets. Some are meant to be sourced in your .bashrc, others executed.

Source them in your .bashrc to have them take effect.

## timetrace.sh

A handy script for adding timing data to output lines. Since we're corrupting your output anyway by adding data to it, we go the distance and also tag each line with `STDERR` or `STDOUT`, depending on which stream it was emitted on. And we keep them separate in our own output, too. Arguments are `eval`'d as raw `bash` code. Because I use `bash`. If you want to fix it, go grab the current user's preferred shell, and feed the arguments as commands into that inside the subshell. Maybe with a pipe? Or using something like `$sh <( printf '%s\n' "$@" )`, and let `bash` feed it a fifo.

```
$ ./timetrace.sh "echo hi"
Wed 29 Apr 2020 08:20:02 PM EDT: STDOUT: hi
```

```
$ ./timetrace.sh ">&2 echo hi"
Wed 29 Apr 2020 08:16:05 PM EDT: STDERR: hi
```

