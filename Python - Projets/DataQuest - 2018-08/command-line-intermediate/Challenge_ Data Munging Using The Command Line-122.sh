## 1. Data munging ##

/home/dq$ ls -al

## 2. Data exploration ##

/home/dq$ head -n 10 *.csv

## 3. Filtering ##

/home/dq$ tail -n 48853 Hud_2005.csv >combined_hud.csv

## 4. Consolidating datasets ##

/home/dq$ tail -n 64535 Hud_2013.csv >>combined_hud.csv

## 5. Counting ##

/home/dq$ bash script