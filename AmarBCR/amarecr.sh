#!/bin/sh
sh ecr.sh prepare
sh ecr.sh validate
sh ecr.sh transfer
sh ecr.sh report
