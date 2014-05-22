# edam’s general-purpose makefile!

http://ed.am/dev/make/edam-mk  
Have you ever wanted a generic, simple, easy to configure, flexible makefile for everyday development? Don’t want to have to invoke automake/autoconf or construct new makefiles by hand for each program/project? This may be what you’re looking for.

## Features:

- Suited to development, not distribution
- Easy configuration (documented below, reference in the makefile itself)
- Support for C, C++, assembly (nasm only) and D (gdc only) source files
- Build modes (release, debug and profile mode)
- Subdirectories/sub-projects (for multiple build targets and automatic recursion when building/cleaning)
- A sophisticated dependency file generation system
- Can live alongside another build system, such as a GNU autotools one.


## QuickStart

Usage is simple. Create a file named “Makefile” alongside your source code. In the Makefile, specify your project’s settings (by defining some variables that describe it; documentation follows) and then include edam.mk at the end. It couldn’t be simpler.
First, cp edam.mk to home dir for sharing with all project:
```
mkdir -p ~/script
cp edam.mk ~/script/.
```
Then create Makefile in our project dir:
```
TARGET = my_program
SOURCES = main.c foo.c
IncDirs =
LibDirs =
LIBRARIES = bar
include ~/script/edam.mk
```
As you can see from the include line at the end, I keep the general-purpose makefile at ~/script/edam.mk. This means I can easily replace it globally when bugs are fixed and improvements made. You can just as easily keep a separate copy of edam.mk with each project’s source code though, if that is preferred.

## Target Settings

The TARGET variable specifies the name of the target file. By default an executable is built, so if you want to build a static or a shared library you will need to set the boolean MKSTATICLIB or MKSHAREDLIB variables.

For example, to build your shared libtim.so, you might go:
```
MKSHAREDLIB = 1
TARGET = libtim.so
```
You can only build one target per Makefile. If you need to build more, use the SUBPROJS variable (see below).

Also, you don’t need to specify the “.so” or “.a” suffixes in the TARGET as they are automatically appended. The same is true for the “lib” prefix for shared libraries. If you don’t want to have “lib” automatically prepended to the TARGET, you can set the boolean NOLIBPREFIX variable.

## Building sub-projects and subdirectories

You may also want to build sub-projects or subdirectories. These can be specified with the SUBPROJS and SUBDIRS variables. Sub-projects and subdirectories are always built before the target since the target may depend on them (and subdirectories before sub-projects for the same reason). Both the SUBPROJS and SUBDIRS variables are space-separated lists.

The purpose of sub-projects is to allow you to build more than one target in a directory. Since you can only specify one target in your Makefile, the way to build more than one it is to create a separate makefile for each target and specify these makefiles as sub-projects in the main Makefile. So, for example, you might create the makefiles “proj1.mk” and “proj2.mk” which each build their own target. Then, in the main Makefile, you can specify proj1 and proj2 as sub-projects (note that “.mk” is automatically appended to sub-projects in the SUBPROJS variable).

For example:
```
SUBPROJS = proj1 proj2
SUBDIRS = subdir1 subdir2
```
would cause make to be run four times: first in the subdirectories subdir1 and subdir2 and then with the makefiles proj1.mk and proj2.mk.

Additionally, when subdirectories are built, if a file named “emake.mk” exists in a subdirectory, then this will be used instead of the default Makefile (or other files) that make defaults to using. This is to allow the use of this general-purpose makefile alongside other build systems.
