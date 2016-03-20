#!/bin/bash

sxiv -t -r $@ &
sleep 1
i3-msg focus left
