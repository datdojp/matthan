#!/bin/bash
kill $(cat tmp/pids/thin.0.pid)
kill $(cat tmp/pids/thin.1.pid)
kill $(cat tmp/pids/thin.2.pid)

service nginx stop
