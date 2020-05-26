#!/usr/bin/env fish

set scripts ~/Projects/astrophotography/siril

siril -s "$scripts/flats.ssf"
find -name '*.seq' -delete
