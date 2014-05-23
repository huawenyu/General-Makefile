# Purpose

This sample build structure demonstrates one method of doing a flat
 build using GNU make and gcc. One of the main
design goals is that each involved directory must contain a file
called "Makefile" (maybe actually "GNUmakefile" since we
rely on GNU Make features), such that it feels like a traditional
recursive structure.  The idea is that a user should be able to
simply type "make" in any directory and get a good build. In fact
all of the makefiles include each other to form a single logical
makefile which has the same behavior regardless of the point of
entry.

This model demonstrates dependency generation for C and C++ code.
It also implements a system adapted from the Linux kernel which
invalidates object files and triggers a rebuild when compiler flags
change.

# QuickStart

```
$ cat Config.mk  <<< config our compile flags
$ make
$ make all       <<< build everything
$ make clean     <<< clean intermediate files, leave execute file
$ make realclean <<< clean everything of output as the initial checkout status
$ make help
```
