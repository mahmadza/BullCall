
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
curl https://www.asnb.com.my/dpv2_thedisplay-print.php > $page
#there has been several iterations of the access points...





#grab date
#here, I choose the Malay format
# date_malay=$(awk '$0~"lblDate"{
#   split($0,x,">")
#   split(x[2],y,"<")
#   print y[1]
# }' $page | sed 's/ /_/g')

date_malay=$(awk '/HARGA HARI INI/{print $4"_"$5"_"substr($6,1,4)}' $page | \
tr [:lower:] [:upper:])

echo $date_malay

# grab prices and print to separate files
price_prefix=$(mktemp)
cat $page | awk -v pre=$price_prefix \
'$0~/<td>AS/{
  fund = substr($1,5)$2$3$4
  price[fund]=1}
$0~/<td width=/{
  getline
  price[fund] = $1
  target = pre"_"fund
  print price[fund] > target
  print price[fund], target
  }'



#from the saved webpage, grab NAV price list
price_list=$(mktemp)
cat $page | \
  awk -v OFS="\t" '$0~"GridView1"{
    ok=1
  }
  (ok){

    #if($0~"width:90px")    previous condition for old webpage
     if($0~">AS")           #use the fund prefix
    {
      split($0,x,">")
      split(x[2],y,"<")
      fund_name=y[1]
      gsub(" ","_",fund_name)

      split(x[4],z,"<")
      fund_price=z[1]

      print fund_name,fund_price

    }
  }' > $price_list

#check if date is already present
#if not, append new NAB price
if grep "$date_malay" daily_prices.txt; then
    echo "Date already present"
  else
    cat $price_list | \
      awk -v OFS="\t" -v p="$date_malay" '{name[NR]=$2}
        END{
          line=p
          for(i=1;i<=NR;i++)
            line=line"\t"name[i]
          print line
        }' >> daily_prices.txt          #here, you can set daily_prices.txt to your own output
fi

#clean up
rm $page $price_list

exit 0

#####
