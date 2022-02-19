
## Performing matches with compiled objects [here](https://www.python-engineer.com/posts/regular-expressions/)
Once we have our pattern, we can search for this pattern in the text / string that we want to look up. RE has 4 different methods:

- `match():` Determine if the RE matches at the beginning of the string.
- `search():` Scan through a string, looking for any location where this RE matches.
- `findall():` Find all substrings where the RE matches, and returns them as a list.
- `finditer():` Find all substrings where the RE matches, and returns them as an iterator.


## Methods on a Match object
- `group():` Return the string matched by the RE
- `start():` Return the starting position of the match
- `end():` Return the ending position of the match
- `span():` Return a tuple containing the (start, end) positions of the match


## Meta characters
Metacharacters are characters with a special meaning:
All meta characters: `. - ^ $ * + ? { } [ ] \ | ( )` A `\` shoulb escaped with `\\`
Meta characters need need to be escaped (with ) if we actually want to search for the char.

- `.` Any character (except newline character) 
- `^` Starts with `"^hello"`
- `$` Ends with `"world$"`
- `*` Zero or more occurrences `"aix*"`, `"\d*`
- `+` One or more occurrences `"aix+"`, 
- `?` Zero or one. Optional character
- `{ }` Exactly the specified number of occurrences `"al{2}"`, `"\d{3}"`
- `[]` A set of characters or number or underscore. We can also specify a range here `"[a-f]"` ===> "[abcdf]", `[a-z]`, `[0-9]`, `[A-Z]`, `[a-zA-Z]`, `[a-zA-Z0-9_]`, `[a-z0-9_]`
- `\` Signals a special sequence (can also be used to escape special characters) `"\d"`
- `|` Either or "com|edu|org". 
- `( )` Capture and group


## More Metacharacters / Special Sequences
A special sequence is a \ followed by one of the characters in the list below, and has a special meaning:

- `\d` :Matches any decimal digit; this is equivalent to the class `[0-9]`.
- `\D` : Matches any non-digit character; this is equivalent to the class `[^0-9]`.
- `\s` : Matches any whitespace character;
- `\S` : Matches any non-whitespace character; this will print words, characters and underscore `_`
- `\w` : Matches any alphanumeric (word) character; this is equivalent to the class [a-zA-Z0-9_].
- `\W` : Matches any non-alphanumeric character; this is equivalent to the class [^a-zA-Z0-9_]. This will just print while spaces
- `\b` Returns a match where the specified characters are at the beginning a block or a word. 
- `\B` Returns a match where the specified characters are present, but NOT at the beginning of a block or a word
- `\A` Returns a match if the specified characters are at the beginning of the string `"\AThe"`. This is equivalent to `^`
- `\Z` Returns a match if the specified characters are at the end of the string `"End\Z"`. This is equivalent to `$`

## Sets
A set is a set of characters inside a pair of square brackets [] with a special meaning. Append multiple conditions back-to back, e.g. [aA-Z].
A ^ (caret) inside a set negates the expression.
A - (dash) in a set specifies a range if it is in between, otherwise the dash itself.

Examples:
- `[arn]` Returns a match where one of the specified characters (a, r, or n) are present
- `[a-n]` Returns a match for any lower case character, alphabetically between a and n
- `[^arn]` Returns a match for any character EXCEPT a, r, and n
- `[0123]` Returns a match where any of the specified digits (0, 1, 2, or 3) are present
- `[0-9]` Returns a match for any digit between 0 and 9
- `0-5` Returns a match for any two-digit numbers from 0 and 5
- `[a-zA-Z]` Returns a match for any character alphabetically between a and z, lower case OR upper case


## Quantifier
- `*` : 0 or more
- `+` : 1 or more
- `?` : 0 or 1, used when a character can be optional
- `{4}` : exact number
- `{4,6}` : range numbers (min, max)


## Modifying strings
- `split()`: Split the string into a list, splitting it wherever the RE matches
- `sub()`: Find all substrings where the RE matches, and replace them with a different string

## Grouping
- `( )` is used to group substrings in the matches.

## Conditions
- Use the `|` for either or condition.