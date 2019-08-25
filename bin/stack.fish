#!/usr/bin/env fish

function info
    echo -e "\\033[1m\\033[32m>>>\\033[0m\\033[0m $argv"
end

function error
    echo -e "\\033[1m\\033[31m!!!\\033[0m\\033[0m $argv"
    exit 1
end

set scripts ~/Projects/astrophotography/siril
set required biases darks flats lights

for dir in $required
    if ! test -d $dir
        error "The directory \"$dir\" must exist and contain RAW image files"
    end
end

info 'Creating master bias file'
siril -s "$scripts/biases.ssf"
find biases -name 'bias_[0-9]*.fit' -delete

info 'Creating master flat file'
siril -s "$scripts/flats.ssf"
find flats -name 'flat_[0-9]*.fit' -delete
find flats -name 'pp_flat_[0-9]*.fit' -delete

info 'Creating master dark file'
siril -s "$scripts/darks.ssf"
find darks -name 'dark_[0-9]*.fit' -delete

info 'Preprocessing lights'
siril -s "$scripts/preprocess_lights.ssf"
find lights -name 'light_[0-9]*.fit' -delete
find lights -name 'pp_light_[0-9]*.fit' -delete

info 'Stacking lights'
siril -s "$scripts/stack_lights.ssf"
find lights -name 'r_pp_light_[0-9]*.fit' -delete

info 'Removing sequence files'
find . -name '*.seq' -delete
