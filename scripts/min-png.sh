#!/bin/sh

find -name '*.png' -exec pngquant --ext .png -v  --skip-if-larger -f {} \;
