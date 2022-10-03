#!/bin/bash
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt reinstall blueman -y
sudo apt reinstall bluetooth -y
sudo systemctl enable blueman-mechanism.service
sudo systemctl enable bluetooth.service
sudo /etc/init.d/bluetooth start
