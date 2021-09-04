#!/bin/bash

###################################################
#This script is to grab NAV (Net Asset Value) of
#ASNB (Amanah Saham Nasional Berhad) mutual funds
###################################################

#first, download page into a temporary file
page=$(mktemp)
#curl http://www.asnb.com.my/price.aspx > $page
#curl http://www.asnb.com.my:8080/ASNBWSP/Price_print.aspx > $page
#update 01/01/2020
#curl http://www.asnb.com.my:8080/ASNBWSP/printPrice.aspx > $page
#update 17/09/2020
#curl https://www.asnb.com.my/dpv2_thedisplay-print.php > $page
#there has been several iterations of the access points...

#update 30/08/2021
curl https://www.asnb.com.my/dpv2_thedisplay-printnewBM.php > $page


# grab date in Malay
date_malay=$(awk '/HARGA HARI INI/{print $4"_"$5"_"substr($6,1,4)}' $page | \
tr [:lower:] [:upper:])

echo $date_malay

# grab prices and print to separate files
prefix=$(mktemp)
cat $page | awk -v pre=$prefix \
  '$0~/<td>AS/{
    fund = substr($1,5)$2$3$4
    price[fund]=1}
  $0~/<td width=/{
    getline
    price[fund] = $1
    target = pre"_"fund
    print price[fund] > target
    print fund, price[fund]
    }'

#check if date is already present
#if not, append new NAV
if grep "$date_malay" daily_prices.txt; then
    echo "Date already present"
  else
    echo -en $date_malay"\t"$(cat ${prefix}_ASN)"\t"\
    $(cat ${prefix}_ASNEquity2)"\t"\
    $(cat ${prefix}_ASNImbang1)"\t"\
    $(cat ${prefix}_ASNEquity3)"\t"\
    $(cat ${prefix}_ASNSara1)"\t"\
    $(cat ${prefix}_ASB)"\t"\
    $(cat ${prefix}_ASM2Wawasan)"\t"\
    $(cat ${prefix}_ASM)"\t"\
    $(cat ${prefix}_ASB3Didik)"\t"\
    $(cat ${prefix}_ASM3)"\t"\
    $(cat ${prefix}_ASB2)"\t"\
    $(cat ${prefix}_ASNSara2)"\t"\
    $(cat ${prefix}_ASNEquity5)"\t"\
    $(cat ${prefix}_ASNImbang3Global)"\t"\
    $(cat ${prefix}_ASNEquityGlobal)"\n" >> daily_prices.txt
fi

#clean up
rm $page $prefix*

exit 0

#####
