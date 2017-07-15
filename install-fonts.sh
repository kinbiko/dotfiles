#!/bin/bash

set -e

git clone https://github.com/powerline/fonts.git
cd fonts
./install.sh
cd ../
rm -rf fonts
