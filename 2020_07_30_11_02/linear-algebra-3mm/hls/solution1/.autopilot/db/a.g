#!/bin/sh
lli=${LLVMINTERP-lli}
exec $lli \
    /tmp/tmp.otgFjrVVE0/benchmark.prj/solution1/.autopilot/db/a.g.bc ${1+"$@"}
