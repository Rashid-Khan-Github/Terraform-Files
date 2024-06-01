#!/bin/bash

sudo su
cd /home/centos
git clone https://github.com/Rashid-Khan-Github/robo_infra_standard_shell.git
mv robo_infra_standard_shell/ roboshop-shell
cd roboshop-shell
sh payment.sh