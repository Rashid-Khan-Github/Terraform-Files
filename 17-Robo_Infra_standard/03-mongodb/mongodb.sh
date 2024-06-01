#!/bin/bash

sudo su
cd /tmp
git clone https://github.com/Rashid-Khan-Github/robo_infra_standard_shell.git
mv robo_infra_standard_shell/ roboshop-shell
cd roboshop-shell
sh mongodb.sh