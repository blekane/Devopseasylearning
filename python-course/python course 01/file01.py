jabber = open("/Users/tia/Downloads/python-course/sample.txt",'r')
# jabber = open("C:\\Documents and Settings\\tim\\My Documents\\sample.txt", 'r')

print("_" * 60)
for line in jabber:
    print(line)
jabber.close()


print("_" * 60)
for line in jabber:
    if "jabberwock" in line.lower():
        print(line, end='')
jabber.close()

print("_" * 60)
with open("/Users/tia/Downloads/python-course/sample.txt", 'r') as jabber:
    for line in jabber:
        if "JAB" in line.upper():
            print(line, end='')

print("_" * 60)
with open("/Users/tia/Downloads/python-course/sample.txt", 'r') as jabber:
    line = jabber.readline()
    while line:
        print(line, end='')
        line = jabber.readline()

print("_" * 60)
sample_txt = """
The jaws that bite, the claws that catch!
Beware the Jubjub bird, and shun
The frumious Bandersnatch!"

He took his vorpal sword in hand:
Long time the manxome foe he sought,
So rested he by the Tumtum tree,
And stood a while in thought.

And, as in uffish thought he stood,
The Jabberwock, with eyes of flame,
Came whiffling through the tulgey wood,
And burbled as it came!

One two! One two! And through and through
The vorpal blade went snicker-snack!
He left it dead, and with its head
He went galumphing back.

"And hast thou slain the Jabberwock?
Come to my arms, my beamish boy!"
"Oh frabjous day! Callooh! Callay!"
He chortled in his joy.

'Twas brillig, and the slithy toves
Did gyre and gimble in the wabe:
All mimsy were the borogoves,
And the mome raths outgrabe.
"""

# print(sample_txt)
