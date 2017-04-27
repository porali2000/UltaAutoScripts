#!/bin/bash
tput setaf 3
echo Extract From FiPay
if [ ! -z $1 ]; 
	then export store=$1; echo 'Store# = ' $store; 
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

if [ ! -z $4 ]; 
	then export authcode=$4;  
	else read -p 'Enter Auth Code# = ' authcode;
fi

if [ ! -z $5 ]; 
	then export card=$5; echo 'Card last 4# = ' $card; 
	else read -p 'Enter  Card last 4# = ' card; 
fi





echo 'Reg# = ' $reg
echo 'Auth Code# = ' $authcode;
echo 'Card last 4# = ' $card;

tput setaf 7

cd /d/ULTA/work/automate/scripts

rm -f ../temp/filter.log
touch filter
fileToFilter=$store"_"$reg"_fipay.log"

 
rm -rf ../arch/fi_"$card"_card_"$tran"
 
#firstline=$(grep --color -m 1 -n -o $card ../temp/$fileToFilter|head -1|awk -F':' '{print $1}p')
#lastline=$(grep --color -n -o $card ../temp/$fileToFilter| tail -1|awk -F':' '{print $1}')p


mkdir ../arch/fi_"$card"_card_"$tran"
cp ../temp/"$fileToFilter" ../arch/fi_"$card"_card_"$tran"/"$fileToFilter"
export reg=0$reg0


grep --color -E ",Sale.*,.*$tran$reg" ../arch/fi_"$card"_card_"$tran"/"$fileToFilter" --> ../arch/fi_"$card"_card_"$tran"/"$tran"_Sale.log
grep --color -E ",Refund.*,.*$tran$reg" ../arch/fi_"$card"_card_"$tran"/"$fileToFilter" --> ../arch/fi_"$card"_card_"$tran"/"$tran"_Refund.log
grep --color -E ",Void.*,.*$tran$reg" ../arch/fi_"$card"_card_"$tran"/"$fileToFilter" --> ../arch/fi_"$card"_card_"$tran"/"$tran"_Void.log

grep --color -E "101,,,0,.*\*$tran$reg.*,Approved" ../arch/fi_"$card"_card_"$tran"/"$fileToFilter" --> ../arch/fi_"$card"_card_"$tran"/"$tran"_approved.log
grep --color -E "$authcode,Approved" ../arch/fi_"$card"_card_"$tran"/"$fileToFilter" --> ../arch/fi_"$card"_card_"$tran"/"$authcode"_approved_by_authcode.log 


grep --color -E "\*$card," ../arch/fi_"$card"_card_"$tran"/"$fileToFilter" --> ../arch/fi_"$card"_card_"$tran"/"$card"_card_all_trans.log 


 
#grep --color -E "[F][I][P][A][Y][P][1]|[T][C][P][C][O][M][1]|[*][*][*][*]" ../arch/fi_"$card"_card_"$tran"/"$fileToFilter" --> ../arch/fi_"$card"_card_"$tran"/fi_"$card"_card__"$tran"pay_all_request.log
#grep --color -E "[T][S][E][N][D][ ][D]|[T][D][A][T][A][ ][D]" ../arch/fi_"$card"_card_"$tran"/"$fileToFilter" --> ../arch/fi_"$card"_card_"$tran"/"$card"_TREQ.log
#grep --color -E "[A][p][p][r][o][v][e][d]" ../arch/fi_"$card"_card_"$tran"/"$fileToFilter" --> ../arch/fi_"$card"_card_"$tran"/"$card"_Approved_Tran.log
#grep --color -E '['"$card"'*Approved]' ../arch/fi_"$card"_card_"$tran"/"$fileToFilter" --> ../arch/fi_"$card"_card__"$tran"/fi_"$card"_card_"$tran"pay_card_"$card".log

grep --color -E "101,,,0,.*\*$card| \*$card.*,Approved" ../arch/fi_"$card"_card_"$tran"/"$fileToFilter" --> ../arch/fi_"$card"_card_"$tran"/"$card"_all_approved_request.log 

grep --color -E "[T][S][E][N][D][ ][D].*\*$card,|[T][D][A][T][A][ ][D].*\*$card," ../arch/fi_"$card"_card_"$tran"/"$fileToFilter" --> ../arch/fi_"$card"_card_"$tran"/"$card"_trequest.log
grep --color -E "[E][R][R][O][R]" ../arch/fi_"$card"_card_"$tran"/"$fileToFilter" --> ../arch/fi_"$card"_card_"$tran"/"$card"_error.log
grep --color -E "[W][A][R][N]" ../arch/fi_"$card"_card_"$tran"/"$fileToFilter" --> ../arch/fi_"$card"_card_"$tran"/"$card"_warn.log

 
#start ../arch/fi_"$card"_card_"$tran"/filter_"$fileToFilter"

read -p 'Remove All Quick view Fi Folder? y : ' removeflag; 

if [ 'y' == $removeflag ]; 
	then export removeflag=$6; echo Removing All Quick view fi_ folder;rm -rf ../view/fi_*; 
fi

rm -rf ../view/fi_"$card"_card_"$tran"
mkdir ../view/fi_"$card"_card_"$tran"
cp ../arch/fi_"$card"_card_"$tran"/* ../view/fi_"$card"_card_"$tran"
 
tput setaf 6 && echo "Extract Complete"
tput setaf 6 && echo "See "$card" directory"
tput setaf 2 && echo "efe complete" 

exit

