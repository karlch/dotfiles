#!/bin/bash

# Energieverwaltung für audiocodec
echo '1' > '/sys/module/snd_hda_intel/parameters/power_save'

# NMI wathcdog sollte ausgeschaltet sein
echo '0' > '/proc/sys/kernel/nmi_watchdog'
