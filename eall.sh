#!/bin/bash
tput setaf 3
read -p 'Enter Store# = ' store
read -p 'Enter Reg# = ' reg
#read -p 'Enter BusinessDate# in MMDDYYYY = ' businessDate
read -p 'Enter Tran# = ' tran
tput setaf 7
cd /d/ULTA/work/automate/scripts
sh eft.sh $store $reg $tran && sh eff.sh $store $reg $tran && sh efe.sh $store $reg $tran