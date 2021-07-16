#!/bin/bash

# make sure we have enough space to build packages
mkdir $HOME/tmp
export TMPDIR=$HOME/tmp

# create the environment using the default python3
virtualenv -p python3 ~/work/pyenv-1

# activate the environement
source ~/work/pyenv-1/bin/activate

# install all dependencies
pip install -r requirements.txt
