#!/bin/bash
alias estrinfo=sh /d/ULTA/work/automate/scripts/estrinfo.sh
tput setaf 3
read -p 'Enter Wilcard# = ' wildcard
tput setaf 7
cd /d/ULTA/work/automate/scripts
grep -a  --color -E "$wildcard" /d/ULTA/work/automate/data/storeinfo.csv