#!/bin/bash
set -e

echo -n "Installing gdb ... "
export DEBIAN_FRONTEND=noninteractive
apt-get -qq update
apt-get -qq install gdb > /dev/null && echo "ok" || echo "failed"

echo -n "Installing rails ... "
gem install rails --silent && echo "ok" || echo "failed"

echo -n "Reverting to a vulnerable state ... "
git checkout 7d0b92c0b6306b0d934725623f4886b82c85edb2 &> /dev/null && echo "ok" || echo "failed"

echo -n "Compiling nokogiri ... "
export CFLAGS="-O0"
export CPPFLAGS="-O0"
bundle install --quiet && bundle exec rake compile &> /dev/null && echo "ok" || echo "failed"

echo "Press F5 to launch and debug the proof of concept"
