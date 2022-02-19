### Regular Expressions (Regex) 
- Tutorial: How to Match Any Pattern of Text [here](https://www.youtube.com/watch?v=sa-TUpSx1JA&t=114s)
- Regular Expression Basics [here](https://www.youtube.com/watch?v=KJG1dETacLI)

`ls -d D*`: list all directory that start with `D`
`ls -d *l*`: list all directory that has a little `l` in between
`ls -l ~/Desktop/*.txt`: list all files that ends with `.txt` on the desktop
`cat file.txt | grep ^t`: search for strings that start with `t`
`cat file.txt | grep e$`: search for strings that end with `e`
```sh
#!/bin/bash
321-555-4321
123.555.1234
123*555*1234
800-555-1234
900-555-1234
```
cat numbers.txt |egrep "[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]"
echo
cat numbers.txt |egrep "[0-9]{3}-[0-9]{3}-[0-9]{4}"

echo
cat numbers.txt |egrep "[0-9]{3}.[0-9]{3}.[0-9]{4}"

echo
cat numbers.txt |egrep "[0-9]{3}\.[0-9]{3}\.[0-9]{4}"

echo
cat numbers.txt |egrep "[0-9]{3}\-[0-9]{3}\-[0-9]{4}"

echo
cat numbers.txt |egrep "[0-9]{3}\*[0-9]{3}\*[0-9]{4}"


# OUTPUT
321-555-4321
800-555-1234
900-555-1234

321-555-4321
800-555-1234
900-555-1234

321-555-4321
123.555.1234
123*555*1234
800-555-1234
900-555-1234

123.555.1234

321-555-4321
800-555-1234
900-555-1234

123*555*1234
```