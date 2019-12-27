
#!/bin/bash

###################################################
#This script is to grab NAV (Net Asset Value) of
#ASNB (Amanah Saham Nasional Berhad) mutual funds
###################################################

cd /Users/zabidi/ASBprice/

#first, download page into a temporary file
page=$(mktemp)
curl http://www.asnb.com.my:8080/ASNBWSP/Price_print.aspx > $page

#grab date
#here, I choose the Malay format
date_malay=$(awk '$0~"lblDate"{
  split($0,x,">")
  split(x[2],y,"<")
  print y[1]
}' $page | sed 's/ /_/g')

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
