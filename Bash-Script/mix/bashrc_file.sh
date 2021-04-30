echo -n "Uptime: "; uptime
echo ""

MYNAME='Kevin Skoglund'
export MYNAME

export LESS='-M'
# must use double-quotes when calling a shell variable
export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:$PATH"

export HISTSIZE=10000                      # 500 is default
export HISTFILESIZE=1000000
export HISTTIMEFORMAT='%b %d %I:%M %p '    # using strftime format
export HISTCONTROL=ignoreboth              # ignoredups:ignorespace
export HISTIGNORE="history:pwd:exit:df:ls:ls -la:ll"

export PS1="\W > "

alias ll='ls -lahG'
alias home='cd ~'
alias up='cd ..'
alias h='history'

# can also redefine a command to add options
alias mv='mv -i'
alias cp='cp -i'
alias rm='rm -i'
alias df='df -h'
alias du='du -h'
alias mkdir='mkdir -p'

# can be used to fix common typos you make
alias pdw='pwd'

# GREP color codes
# Attributes:   Text color:    Background:
#   0 reset all   30 black       40 black
#   1 bright      31 red         41 red
#   2 dim         32 green       42 green
#   4 underscore  33 yellow      43 yellow
#   5 blink       34 blue        44 blue
#   7 reverse     35 purple      45 purple
#   8 hidden      36 cyan        46 cyan
#                 37 white       47 white
# Separate with ";"
# I love black and green
export GREP_COLOR="30;46"

# Specify options grep should use by default
# color = auto means the colo will display only in the terminal and not when i redirect the output to a  file.
# color = never means it will never display the color.
# color =always means it will always display the color.
export GREP_OPTIONS="--color=auto"
