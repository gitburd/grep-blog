#!/bin/bash

# This searches your history for git commands:
history | grep 'git'

# -E: extended regulat expression
echo grey | grep -E 'gr(a|e)y'

# if statement:
if echo '42' | grep -Ewq '\d{2}'; then echo true; fi

# Running this command inside the root of the example directory searches the file text.txt for lines that include the pattern ‘time’,
grep 'time' quotes.txt
# By default the matches are displayed in red and the whole line is printed. The first line of the results includes “Time” which is capitalized and not a match and “Lunchtime” which is a match because there is no specification that the pattern can’t be part of a longer word. 

# To include “Time” use -i for a case insensitive search:
grep -i 'time' quotes.txt

# And to exclude “Lunchtime” and “times” use -w for a word-boundary search: 
grep -w 'time' quotes.txt

# To match any word that contains “time” (capitalized or not) adjust the pattern to this: 
grep '\S*[Tt]ime\S*' quotes.txt
# \S: any non-whitespace character, *:  zero or more repetitions, [Tt]: “T” or “t”

# -o prints only matching text, not the whole line
# -n prints the line number of the match
grep -on '\S*[Tt]ime\S*' quotes.txt

# -c prints the number of lines with matches, not the number of matches
grep -c '\S*[Tt]ime\S*' quotes.txt

# This prints the number of matches
grep -o '\S*[Tt]ime\S*' quotes.txt | wc -l

# Send all the lines that match the pattern to a new file with this: 
grep '\w*[Tt]ime\w*' quotes.txt > match.txt
cat match.txt

# -v prints all lines that don’t match the pattern
grep -v '\S*[Tt]ime\S*' quotes.txt > not-match.txt
cat not-match.txt

# get all the non epmty non comment lines
grep -Ev "^$|^#" ./commands.sh

# reading patterns from files:
grep -Evf ./patterns/ignore.txt ./commands.sh | grep -Ef ./patterns/match.txt

# context lines:
grep -C 3 'silence' excerpt.txt

# search the directory:
grep -r 'silence' .

# This passes as regular expression instead of the whole directory
# so only files with the .txt extenssion will be searched
# But this doesn't work recursively, so txt files in nested folders can't be searched
grep -r 'silence' *.txt

# piping the results of find into grep will search txt files in nested folders
find . -name '*.txt' -exec grep -H 'silence' {} \;
find . -name '*.txt' -print0 | xargs -0 grep 'silence'

# change case with tr:
echo "don't panic" | tr a-z A-Z

# regular expression ignoring whitespace
grep -E 'extra\s+spaces' panic.txt

# squash whitespace with tr:
grep -E 'extra\s+spaces' panic.txt | tr -s ' '

# delete empty lines with sed:
sed -i '.bak' '/^$/d' panic.txt

# Use find and sed to find and replace only in .txt files
find . -name '*.txt' -exec sed -i .bak 's/Panic/PANIC/g' {} +

# Use grep and sed together to rewrite a file conditionally only if that file contains a specific pattern:
grep -l 'modify' *[^(.sh)] | while read file ; do
    print "modifying $file"
    sed '/PANIC/!d' $file> $file.tmp
    mv $file.tmp $file
done

# use find to delete all the .bak files:
find . -name '*.bak' | xargs rm
find . -name '*.bak' -exec rm -i {} \;
