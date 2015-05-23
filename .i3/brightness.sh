#!/bin/sh
# shell script to find out cmus data

brightness=$(xbacklight)
brightness=${brightness%.*}
echo "${brightness}%"
