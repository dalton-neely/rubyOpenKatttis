# Open Kattis
## Ruby
### Problem
* [Tarifa](https://open.kattis.com/problems/tarifa)

### Algorithm
1. read in first line of STDIN as X (the number of megabytes per month)
2. read in the second line of STDIN as N (the number of months)
3. Increment N by one
4. Multiply X by the new N to get totalMegabytes
5. loop N - 1 times and add up the STDIN to get the total megabytes used
6. Subtract the total megabytes used from the totalMegabytes
7. Output the left over megabytes to STDOUT

### What We Need
* a "Plan" class
    * megsPerMonth
    * numMonths
    * totalMegs
    * leftover
    * calcTotalMegs
    * calcLeftover
    * print