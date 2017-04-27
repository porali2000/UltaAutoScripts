#!/bin/bash

tput setaf 3

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
tput setaf 7

cd /d/ULTA/work/automate/scripts

rm -rf ../arch/x_"$tran"
 
fileToFilter=$store"_"$reg"_xstore.log"
 
echo File to Filter : $fileToFilter
 
firstline=$(grep --color -m 1 -n -o "\\["$tran ../temp/$fileToFilter|head -1|awk -F':' '{print $1}p')
lastline=$(grep --color -n -o "\\["$tran ../temp/$fileToFilter| tail -1|awk -F':' '{print $1}')
 
echo Filtering file from line# $(($firstline-100)) to $(($lastline+100))
if test -z $firstline; then
 	tput setaf 1 && echo -e !!  Transaction details not found for $tran !!
	tput setaf 2 && echo "eff complete"
	exit
fi

mkdir ../arch/x_"$tran"
cp ../temp/"$fileToFilter" ../arch/x_"$tran"/"$fileToFilter"
cp ../temp/$store"_"$reg"_ej.log" ../arch/x_"$tran"/$store"_"$reg"_ej.log"
cp ../temp/$store"_"$reg"_fipay.log" ../arch/x_"$tran"/$store"_"$reg"_fipay.log"

sed -n "$(($firstline-100)), $(($lastline+100))p" ../temp/"$fileToFilter" --> ../arch/x_"$tran"/"$tran"_full.log
 
grep --color -E "[C][H][A][I][N]|[*][*]|[-][-]" ../arch/x_"$tran"/"$tran"_full.log --> ../arch/x_"$tran"/"$tran"_quick_view_1.log
grep --color -E "[C][H][A][I][N]|[*][*]|[[][P][r][o][m][p][t]|[[][A][c][t][i][o][n]|[[][I][n][p][u][t]|[[][E][v][e][n][t]|[T][R][A][N][S][A][C][T][I][O][N][ ][[]|[[][F][o][r][m]" ../arch/x_"$tran"/"$tran"_full.log --> ../arch/x_"$tran"/"$tran"_quick_view_2.log
grep --color -E "[[][P][r][o][m][p][t]|[[][A][c][t][i][o][n]|[[][I][n][p][u][t]|[[][E][v][e][n][t]|[T][R][A][N][S][A][C][T][I][O][N][ ][[]|[[][F][o][r][m]|[[][P][r][o][m][p][t]|[[][C][o][n][t][e][x][t][|][M][e][n][u]" ../arch/x_"$tran"/"$tran"_full.log --> ../arch/x_"$tran"/"$tran"_quick_view_3.log 
 
 
grep  --color -E "[I][T][E][M]" ../arch/x_"$tran"/"$tran"_full.log --> ../arch/x_"$tran"/"$tran"_item.log
grep  --color -E "[U][P][C]|[E][A][N]" ../arch/x_"$tran"/"$tran"_full.log --> ../arch/x_"$tran"/"$tran"_upc.log
 
grep --color -E "[,][S][a][l][e]|[,][R][e][f][u][n][d]|[F][i][P][a][y]|[R][e][q][u][e][s][t]|[R][e][s][p][o][n][s][e]" ../arch/x_"$tran"/"$tran"_full.log --> ../arch/x_"$tran"/"$tran"_fipay.log
grep --color -E ".Request sent to FiPay|.Response from Fipay" ../arch/x_"$tran"/"$tran"_full.log --> ../arch/x_"$tran"/"$tran"_request_sent.log


grep --color -E "[ ][C][a][s][h]" ../arch/x_"$tran"/"$tran"_full.log --> ../arch/x_"$tran"/"$tran"_cash.log
grep --color -E "[[][F][o][r][m]" ../arch/x_"$tran"/"$tran"_full.log --> ../arch/x_"$tran"/"$tran"_forms.log 
grep --color -E "[[][E][v][e][n][t]" ../arch/x_"$tran"/"$tran"_full.log --> ../arch/x_"$tran"/"$tran"_events.log 
grep --color -E "[[][P][r][o][m][p][t]" ../arch/x_"$tran"/"$tran"_full.log --> ../arch/x_"$tran"/"$tran"_prompts.log 
grep --color -E "[[][I][n][p][u][t]" ../arch/x_"$tran"/"$tran"_full.log --> ../arch/x_"$tran"/"$tran"_inputs.log 
grep --color -E "[[][P][r][o][m][p][t]" ../arch/x_"$tran"/"$tran"_full.log --> ../arch/x_"$tran"/"$tran"_prompts.log
grep --color -E "[[][A][c][t][i][o][n]" ../arch/x_"$tran"/"$tran"_full.log --> ../arch/x_"$tran"/"$tran"_actions.log
grep --color -E "[[][C][o][n][t][e][x][t][|][M][e][n][u]" ../arch/x_"$tran"/"$tran"_full.log --> ../arch/x_"$tran"/"$tran"_context_menu.log
grep --color -E "[[][I][n][p][u][t]" ../arch/x_"$tran"/"$tran"_full.log --> ../arch/x_"$tran"/"$tran"_inputs.log  
grep --color -E "COMMAND:XBATCH" ../arch/x_"$tran"/"$tran"_full.log --> ../arch/x_"$tran"/"$tran"_commands.log
grep --color -E " TENDER_" ../arch/x_"$tran"/"$tran"_full.log --> ../arch/x_"$tran"/"$tran"_tenders_opted.log


grep  --color -E "[E][R][R][O][R]" ../arch/x_"$tran"/"$tran"_full.log --> ../arch/x_"$tran"/"$tran"_error.log
grep  --color -E "[W][A][R][N]" ../arch/x_"$tran"/"$tran"_full.log --> ../arch/x_"$tran"/"$tran"_warn.log



#grep --color -E ".Request sent to FiPay|.Response from Fipay" ../arch/x_"$tran"/"$tran"_full.log --> ../arch/x_"$tran"/"$tran"_all_fipay_req_res.log
#grep --color -E ".Request sent to FiPay.*\*$tran0$reg|.Response from Fipay.*\*$tran0$reg" ../arch/x_"$tran"/"$tran"_all_fipay_req_res.log --> ../arch/x_"$tran"/"$tran"_request_outofsync.log

tail -n +$lastline ../arch/x_"$tran"/"$tran"_full.log | grep --color -E ".Request sent to FiPay.*\*$tran0$reg|.Response from Fipay.*\*$tran0$reg"  --> ../arch/x_"$tran"/"$tran"_request_outofsync.log

#rm -rf ../arch/x_"$tran"/"$tran"_all_fipay_req_res.log

read -p 'Remove All Quick view x_ Folder? y : ' removeflag; 
if [ 'y' == $removeflag ]; 
	then export removeflag=$4; echo Removing All Quick view x_ folder;rm -rf ../view/x_*; 
fi

rm -rf ../view/x_"$tran"
mkdir ../view/x_"$tran"
cp ../arch/x_"$tran"/* ../view/x_"$tran"
 
tput setaf 6 && echo "Extract Complete"
tput setaf 6 && echo "See "$tran" directory" 
tput setaf 2 && echo "eff complete"
exit
