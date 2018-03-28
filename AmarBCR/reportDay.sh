#!/bin/sh
##每日下午跑批，预防人工批量未跑
cd /home/Amarsoft/app/AmarBCR
./bcr.sh transfer
./bcr.sh report
