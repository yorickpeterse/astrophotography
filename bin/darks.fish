#!/usr/bin/env fish

set scripts ~/Projects/astrophotography/siril

siril -s "$scripts/darks.ssf"
find -name '*.seq' -delete
