#!/usr/bin/env fish

set files *.fits

if [ ! $argv[1] ]
    echo 'You must specify the image kind, such as: flat, dark, light'
    exit 1
end

set kind $argv[1]

for index in (seq (count $files))
    set file $files[$index]

    mv $files[$index] {$kind}_$index.fits
end
