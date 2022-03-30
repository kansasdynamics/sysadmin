#!/bin/bash
# Change the hostname of the system
read -p "Enter Hostname: " HOSTNAME
hostnamectl set-hostname $HOSTNAME
hostname
# This can be accomplished with multiple methods
# nmtui (GUI)
# nmcli general hostname $HOSTNAME
