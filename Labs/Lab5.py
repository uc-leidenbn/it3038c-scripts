#Lab5 leidenbn

import datetime 

print('What is your year of Birth?')
yearofbirth = input()
yearofbirth = int(yearofbirth)

print('What is your month of Birth?')
monthofbirth = input()
monthofbirth = int(monthofbirth)

print('What is your day of Birth?')
dayofbirth = input()
dayofbirth = int(dayofbirth)

now = datetime.datetime.now() 
dob = datetime.datetime(yearofbirth, monthofbirth, dayofbirth) 

difference = now-dob 
seconds = difference.total_seconds()

print('You are this many seconds old: ', seconds) 


