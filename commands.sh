#!/bin/bash

# Running this command inside the root of the example directory searches the file text.txt for lines that include the pattern ‘time’,
grep 'time' ./text.txt
# By default the matches are displayed in red and the whole line is printed. The first line of the results includes “Time” which is capitalized and not a match and “Lunchtime” which is a match because there is no specification that the pattern can’t be part of a longer word. 

# To include “Time” use -i for a case insensitive search:
grep -i 'time' ./text.txt

# And to exclude “Lunchtime” and “times” use -w for a word-boundary search: 
grep -w 'time' ./text.txt

# To match any word that contains “time” (capitalized or not) adjust the pattern to this: 
grep '\S*[Tt]ime\S*' ./text.txt
# \S: any non-whitespace character, *:  zero or more repetitions, [Tt]: “T” or “t”

# -o prints only matching text, not the whole line
# -n prints the line number of the match
grep -on '\S*[Tt]ime\S*' ./text.txt

# -c prints the number of lines with matches, not the number of matches
$ grep -c '\S*[Tt]ime\S*' ./text.txt

# This prints the number of matches
$ grep -o '\S*[Tt]ime\S*' ./text.txt | wc -l

# Send all the lines that match the pattern to a new file with this: 
grep '\w*[Tt]ime\w*' ./text.txt > time.txt
cat time.txt

# -v prints all lines that don’t match the pattern
grep -v '\S*[Tt]ime\S*' ./text.txt > not-time.txt
cat not-time.txt

# now lets search the directory :
grep -r 'ghastly' .

# This passes as regular expression instead of the whole directory
# so only files with the txt extenssion will be searched
# But this doesn't work recursively, so txt files in nested folders can't be searched
grep -r 'ghastly' ./*.txt

# piping the results of find into grep will search txt files in nested folders
find . -type f -name "*.txt" -print0 | xargs -0 grep "ghastly"

find . -name '*txt' -exec grep -H 'ghastly' {} \;

grep -rh 'ghastly' ./*.txt | sed -e 's/^[[:blank:]]*//g' -e 's/ * / /g'
grep -r 'ghastly' ./*.txt | sed -e 's/.txt:[[:blank:]]*/:/g' -e 's/ * / /g'

# Find | grep | sed
$ find . -type f -name "*.txt" -print0 | xargs -0 grep "ghastly" | sed -e 's/.txt: */: /g' -e 's/ * / /g'


history | grep 'git commit'

history | grep 'grep'

grep -B 2 'ghastly' excerpt.txt | sed -e 's/^ *//g' -e 's/ * / /g'
grep -A 1 'ghastly' excerpt.txt | sed -e 's/^ *//g' -e 's/ * / /g'
grep -C 5 'ghastly' excerpt.txt | sed -e 's/^ *//g' -e 's/ * / /g'

# get all the non epmty lines that don't start with a comment 
grep -Ev "^$|^#" ./commands.sh

# now let's find all the commands with pipes in them!
grep -Ev "^\s|^#" ./commands.sh | grep -E "\|"

# files
grep -Evf ./patterns/ignore.txt ./commands.sh | grep -Ef ./patterns/match.txt