albums = [("Welcome to my Nightmare", "Alice Cooper", 1975),
          ("Bad Company", "Bad Company", 1974),
          ("Nightflight", "Budgie", 1981),
          ("More Mayhem", "Emilda May", 2011),
          ("Ride the Lightning", "Metallica", 1984),
          ]

print("_" * 60)
print(len(albums))

print("_" * 60)
for name, artist, year in albums:
    print("Album: {}, Artist: {}, Year: {}"
          .format(name, artist, year))

print("_" * 60)
for name, artist, year in albums:
    print("Album: {}, Artist: {}"
          .format(name, artist))

print("_" * 60)
for i in albums:
    name, artist, year = i
    print("Album: {}, Artist: {}, Year: {}"
          .format(name, artist, year))
