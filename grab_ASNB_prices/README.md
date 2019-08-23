
Add a cronjob to your Linux or OSX to run the grab_master.sh every working day.
If you typically travel and may have only intermittent internet connection, set the cronjob
to run every 20 minutes, from 9am to 8pm, for example.

*/20 9-20 * * 1-5 ~/grab_ASNB_prices/grab_master.sh

When I first started running the cronjob, the page is updated daily around 8am.

Also don't forget to set up the correct path for the output file.
