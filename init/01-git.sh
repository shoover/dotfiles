#!/bin/bash

set -e

sudo apt-get update
sudo apt-get install -y git

git config --global alias.co checkout
