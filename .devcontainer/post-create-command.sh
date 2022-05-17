#!/bin/bash
set -e

echo -n "Installing gdb ... "
export DEBIAN_FRONTEND=noninteractive
apt-get -qq update
apt-get -qq install gdb > /dev/null && echo "ok" || echo "failed"

echo -n "Installing rails ... "
gem install rails --silent && echo "ok" || echo "failed"

echo -n "Compiling nokogiri ... "
export CFLAGS="-O0"
export CPPFLAGS="-O0"
bundle install --quiet && bundle exec rake compile &> /dev/null && echo "ok" || echo "failed"

code -r .devcontainer/readme.md