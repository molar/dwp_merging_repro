#!/bin/bash
set -euo pipefail
CLANG=clang++-18
DWP=llvm-dwp-18
DWARFDUMP=llvm-dwarfdump-18
export LLVM_SYMBOLIZER_PATH=llvm-symbolizer-18
FLAGS="-gsplit-dwarf -g -O3"
$CLANG -c src/a.cpp $FLAGS -o a.o
$CLANG -c src/main.cpp $FLAGS -o main.o

# make individual packages mimicking bazel dwp step
$DWP a.dwo -o a.dwp
$DWARFDUMP --verify a.dwp
$DWP main.dwo -o main.dwp
$DWARFDUMP --verify main.dwp

# combine the dwp packages into one dwp
$DWP a.dwp main.dwp -o main_binary.dwp
$DWARFDUMP --verify main_binary.dwp
#
# passthrough dwp again to trigger invalid creation
$DWP main_binary.dwp -o main_binary_that_crashes.dwp
$DWARFDUMP --verify main_binary_that_crashes.dwp
