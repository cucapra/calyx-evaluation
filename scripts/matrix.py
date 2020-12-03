#!/usr/bin/env python3

from itertools import chain, combinations


def powerset(iterable):
    s = list(iterable)
    return chain.from_iterable(combinations(s, r) for r in range(len(s)+1))


optimizations = ["static-timing", "resource-sharing", "minimize-regs"]

print("OPTS=(")
for opt_set in powerset(optimizations):
    print("  \"" + "-d " + " -d ".join(opt_set) + "\"")
print(")")
