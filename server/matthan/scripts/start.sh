#!/bin/bash
env=production
dir=$(pwd)
shims=/root/.rbenv/shims
mkdir -p tmp/sockets
mkdir -p tmp/pids
RAILS_ENV=production rake assets:precompile
$shims/puma config.ru                                     \
  --tag         matthan.puma                                  \
  --environment $env                                      \
  --workers     2                                         \
  --threads     1:16                                      \
  --bind        unix:///$dir/tmp/sockets/matthan.puma.sock    \
  --pidfile     tmp/pids/matthan.puma.pid                     \
  --preload                                               \
  --daemon