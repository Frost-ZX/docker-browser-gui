#!/bin/bash

# set the home directory
# https://github.com/jlesage/docker-baseimage-gui#the-home-variable
export HOME=/config/home

# start the application
exec /usr/bin/google-chrome-stable --disable-dev-shm-usage --no-sandbox --user-data-dir=/config/chrome-user-data
