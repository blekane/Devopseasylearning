## VIM COMMANDS IN LINUX/UNIX

### What is vim?
**Vim** is a powerful text editor used in CLI (command line interface). Linux uses a lot of configuration files, you'll often need to edit them and vim is a great tool to do so. Alternatives to vim is the command-line editor's `nano`.

### Vim installation
```
apt-get install vim -y
yum install vim -y
```

## Vim Basic Commands
**a or i:** insertion mode          	          

**ctrl+c or esc:** command mode

**:set number:** to turn on line number

**:nohl:** no highlight

**:set nu:** to turn on line number

**:set nonu:** disable line number

**:set ai:** to enable auto-indent

**:set noai:** to disable auto-indent

**:set background:** dark to  set a dark background

**:qa! Or :q!:** to quit without saving

**:wq**: write and quit

**:x**: write and quit

**:wq! Or :x!:** to force write and quit even though you do not have the permission

**:w:** write without quitting

**o:** new line

**$:** move to the end of the line

**0:** zero move to the beginning of the line

**Shift + g or ]]:** move to the end of the file

**gg or [[:** move to the beginning of the file

**dd:** to delete the line or delete from the beginning to the end of the line

**u:** undo

**ctrl + r:** redo

**}:** move to the next paragraph

**{:** move to the previous paragraph

**3}:** move to the third paragraph and 2} will be second and so on

**d}:** delete a paragraph

**y:** copy

**P:** paste

**yy or cc:** copy a whole line

**5yy or y5y:** to yanked or copy 5 lines

**yy + 2}:** copy two paragraphs. You must be at the beginning of the paragraph

**shift + V:**  V= visual mode and select one line and d to delete

**:/word:** to search for a word, `n` to move forward and `shift + n` to move backward

**:%s/can/tia:** to substitute can by tia in the first line.

**:%s/can/tia/g:** to search and substitute the word can by tia in the whole text (g=global)


## Create a .vimrc if it does not exist
```
touch ~/.vimrc
vim ~/.vimrc
source ~/.vimrc
```
       
**Defualt vim background names**
(colors: default, blue, darkblue, delek, desert, elford, evening, industry, koehler, morning, murphy, pablo, peachpuff, ron, shine, slate, torte, zellner).

**Good color schemes are:** murphy, slate, molokai, badwolf, solarized, torte, dark 

**Copy and paste in .vimrc and source so that change can take effect immediately.**
```
set nu
set background=dark
set autoindent
set cursorline
set softtabstop=4
```

