#!/bin/bash
tput setaf 3
if [ ! -z $1 ]; 
	then export store=$1; echo 'Store# = '$store; 
	else read -p 'Enter Store# = ' store; 
fi

if [ ! -z $2 ]; 
	then export reg=$2; echo 'Reg# = ' $reg; 
	else read -p 'Enter Reg# = ' reg; 
fi

if [ ! -z $3 ]; 
	then export tran=$3; echo 'Tran# = ' $tran; 
	else read -p 'Enter Tran# = ' tran; 
fi

read -p 'Remove All Quick view e_ Folder? y : ' removeflag; 
if [ 'y' == $removeflag ]; 
	then export removeflag=$4; echo Removing All Quick view e_ folder;rm -rf ../view/e_*; 
fi
tput setaf 7

cd /d/ULTA/work/automate/scripts
rm -rf ../e_"$tran"
 
fileToFilter=$store"_"$reg"_ej.log"
 
echo File to Filter : $fileToFilter
 
firstline=$(grep --color -m 1 -n -o "TRANS "$tran ../temp/$fileToFilter|head -1|awk -F':' '{print $1}p')
lastline=$(grep --color -n -o "BARCODE.*"$tran ../temp/$fileToFilter| tail -1|awk -F':' '{print $1}')p
 
echo Filtering file from line# $firstline to $lastline
if test -z $firstline; then
 	tput setaf 1 && echo -e !!  EJ details not found for $tran !!
	tput setaf 2 && echo "efe complete"
	exit
fi

mkdir -p ../arch/e_"$tran"

cp ../temp/"$fileToFilter" ../arch/e_"$tran"/"$fileToFilter"

sed -n "$(($firstline - 6)), $lastline" ../arch/e_"$tran"/"$fileToFilter" --> ../arch/e_"$tran"/"$tran"_receipt.txt 

grep  --color -E "[E][R][R][O][R]" ../arch/e_"$tran"/"$fileToFilter" --> ../arch/e_"$tran"/"$tran"_error.log
grep  --color -E "[W][A][R][N]" ../arch/e_"$tran"/"$fileToFilter" --> ../arch/e_"$tran"/"$tran"_warn.log

rm -rf ../view/e_"$tran"
mkdir -p ../view/e_"$tran"
cp ../arch/e_"$tran"/* ../view/e_"$tran"
 
tput setaf 6 && echo "Extract Complete"
tput setaf 6 && echo "See "$tran" directory"
tput setaf 2 && echo "efe complete" 
exit
