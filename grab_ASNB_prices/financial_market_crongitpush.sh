#!/bin/bash

#copy the latest ASNB prices to GitHub folder
cp /Users/zabidi/ASBprice/daily_prices.txt /Users/zabidi/Documents/GitHub/financial_market/grab_ASNB_prices/

#change directory
cd /Users/zabidi/Documents/GitHub/financial_market

#add file to staging area
git add grab_ASNB_prices/daily_prices.txt

#commit
git commit -a -m "daily_prices.txt update `date`"

#push
git push origin master

#previously, set up git-credential-store
#as per https://stackoverflow.com/questions/56057292/git-push-using-crontab-every-hour-prompting-password
#did:
#git config credential.helper store
#git push https://github.com/mahmadza/financial_market.git
#Username: XXXXX
#Password: XXXXX
#now my credentials are used automatically





##############
