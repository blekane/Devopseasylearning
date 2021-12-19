flowers = [
    "Daffodil",
    "Evening Primrose",
    "Hydrangea",
    "Iris",
    "Lavender",
    "Sunflower",
    "Tiger Lily",
    "42",
]

for flower in flowers:
    print(flower)
print("_" * 60)

separator = " | "
output = separator.join(flowers)
print(output)

print(" ====>> ".join(flowers))
print(", ".join(flowers))
