#!/bin/bash

set -e

sudo apt-get update

sudo apt-get install -y curl

#
# C compilers
#
sudo apt-get install -y build-essential
sudo apt-get install -y clang
