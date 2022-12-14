#! /bin/bash
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

  echo -e "\n\t\t\t\t=> Enter Table Name: \c"
  read tableName
  echo -e "\n\t\t\t\t=> Enter Column Name: \c"
  read coluName

if ! [[ -f $tableName ]]; then
    echo -e "\n\t\t\t\t The Table ${RED}Don't Exist${NC} Choose another Name \n"
    $HOME/DBMS/tableScripts/selectCol.sh
else
    colNum=$(
    awk '
    BEGIN{FS=":"}
        {
            if(NR==1)
                {
                    for(i=1;i<=NF;i++)
                    {
                        if("'$coluName'"==$i) print i
                    }
                }
        }' $tableName 2>> /dev/null)

    if [[ $colNum == "" ]]
    then
        echo -e "\n\t\t\t\tThe Column ${RED}Does't Exist ${NC} "
        $HOME/DBMS/tableScripts/selectCol.sh
    else
    awk 'BEGIN{FS=":"; ORS = "\n-------------------\n"}{print NR " | " $'$colNum'}' $tableName


        echo -e "\n\t\t\t\t1) to show another column \n"
        echo -e "\n\t\t\t\t2) Back to Select menu \n"
        echo -e "\n\t\t\t\t3) Back to Main menu \n"
        echo -e "\n\t\t\t\t=> Enter your choice \c"
        read sele

        case $sele in
        1) $HOME/DBMS/tableScripts/selectCol.sh
        ;;
        2) $HOME/DBMS/tableScripts/selectMenu.sh
        ;;
        3) $HOME/DBMS/main.sh
        ;;
        *) $HOME/DBMS/tableScripts/selectCol.sh
        ;;
        esac
    fi
fi        

$HOME/DBMS/tableScripts/selectMenu.sh