
This repository is to pull the NAV (Net Asset Value) of mutual funds under the management of ASNB (Amanah Saham Nasional Berhad).
ASNB (http://www.asnb.com.my), a fully-owned subsidiary of Permodalan Nasional Berhad (PNB), has 14 funds with ~RM235 billion of Asset Under Management as of 31st December 2018. ASNB is one of the biggest institutional investor in Malaysia.

This repository was created to pull the NAV prices of the ASNB funds, as I could not find any resources on the Web on them.

To pull the NAV prices every working day, add a cronjob to your Linux or OSX to run grab_master.sh.
If you typically travel and may have only intermittent internet connection, set the cronjob to run every 20 minutes, from 9am to 8pm, for example.

Add this to your cronjob:

*/20 9-20 * * 1-5 ~/grab_ASNB_prices/grab_master.sh


(when I first started pulling the NAV prices, the ASNB page is updated daily around 8am).

Also don't forget to set up the correct path for the output file.

Bear in mind that some of the funds, especially the non-fixed priced funds, may charge you either 3% if you invest through EPF (Employee's Provident Fund), or 5% if you do it yourself.

DISCLAIMER: Please consult your financial planner before making any financial decision. This resource is for your education and entertainment only.
