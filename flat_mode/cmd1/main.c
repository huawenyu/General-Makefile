#include <libgen.h>
#include <stdio.h>

#include "../libA/libA.h"
#include "../libB/libB.h"
#include "libC/libC.h"

int
main(int argc, char *argv[])
{
    int i = 0;

    i += a1() + a2();
    i += b1() + b2();
    i += c1() + c2() + c3();

    printf("%s: %d\n", basename(argv[0]), i);

    return i;
}
