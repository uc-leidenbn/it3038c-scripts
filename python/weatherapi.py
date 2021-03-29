import json
import requests

print('Please enter your zip code:')
zip = input()

r = requests.get('http://api.openweathermap.org/data/2.5/weather?zip=12345,us&appid=9ab780ae313e4dbb6786a1668907e3b6' % zip)
data=r.json()
print(data['weather'][0]['description'])
