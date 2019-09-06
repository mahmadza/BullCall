
# Introduction

This repository is to pull the NAV (Net Asset Value) of mutual funds under the management of ASNB (Amanah Saham Nasional Berhad).
ASNB (http://www.asnb.com.my), a fully-owned subsidiary of Permodalan Nasional Berhad (PNB), has 14 funds with ~RM235 billion of Asset Under Management as of 31st December 2018. ASNB is one of the biggest institutional investor in Malaysia.

This repository was created to pull the NAV prices of the ASNB funds, as I could not find any resources on the Web on them.


## Setting Up daily NAV price pull

To pull the NAV prices every working day, add a cronjob to your Linux or OSX to run grab_master.sh.
If you typically travel and may have only intermittent internet connection, set the cronjob to run every 20 minutes, from 9am to 8pm, for example.

Add this to your cronjob:

*/20 9-20 * * 1-5 ~/grab_ASNB_prices/grab_master.sh


(when I first started pulling the NAV prices, the ASNB page is updated daily around 8am).

-don't forget to set up the correct path for the output file
-add column headers (the funds' names) to the output file. When you first run and set up the cronjob, make sure the NAV price values and the output in the output file are consistent by checking the output manually.

Bear in mind that some of the funds, especially the non-fixed priced funds, may charge you either 3% if you invest through EPF (Employee's Provident Fund), or 5% if you do it yourself.

DISCLAIMER: Please consult your financial planner before making any financial decision. This resource is for your education and entertainment only.

## Example output

NAV_120619_230819.txt
This file contains an example output from grab_master.sh, run on the cronjob as above. This is the raw output. Points to note:
1) I have manually added the header to the output file, which consists of the funds' names
2) When the funds are suspended for bookkeeping, you will see that the NAV of the funds is missing (as "Suspended")
3) When there is public holiday during the weekday, the NAV of all funds are also missing. This is because the cronjob do not take into account Malaysia or Kuala Lumpur public holidays

The NAVs of the fixed price can be safely ignored, as their name, fixed price suggest.

From here, several interesting analyses can be performed:
1) correlation between the NAVs
2) the median, minimum or max of the NAVs
3) correlation between the NAVs vs the Dow or KLCI index, or other index for that matter (you'd need to download the datapoints for these indices separately)
4) from (2), you can find the "alpha", i.e the outperformance of the funds vs the reference index
5) how much the NAVs dropped during Christmas 2018, where the Dow and NASDAQ dropped heavily, and how responsive the NAVs were right after
