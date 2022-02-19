import json

with open('states.json') as f: #f is the file that is open
  data = json.load(f)

for state in data['states']:
  print(state['name'], state['abbreviation'], state['area_codes'])

for state in data['states']:
  del state['area_codes']

with open('new_states.json', 'w') as f: #f is the file that is open
  json.dump(data, f, indent=2)
