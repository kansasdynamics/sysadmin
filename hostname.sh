#!/bin/bash
# Change the hostname of the system
read -p "Enter Hostname: " HOSTNAME
hostnamectl set-hostname $HOSTNAME
