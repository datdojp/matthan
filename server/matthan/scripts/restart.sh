#!/bin/bash
thin                                            \
  --tag           matthan                       \
  --rackup        config.ru                     \
  --environment   production                    \
  --servers       3                             \
  --pid           tmp/pids/thin.pid             \
  --socket        tmp/sockets/thin.sock         \
  --onebyone                                    \
  --daemonize                                   \
  --threaded                                    \
  start

service nginx restart