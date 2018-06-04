#!/bin/bash
echo "This is rv.sh"
make
./1-unsequenced-side-effect
./2-buffer-overflow
./3-array-in-struct
./4-buffer-underflow-external
./5-buffer-overflow-environment
./6-int-overflow
./7-out-of-lifetime
./8-int-overflow-tricky
./9-memory-leak
rv-html-report my_errors.json -o report
rv-upload-report `pwd`/report
make clean