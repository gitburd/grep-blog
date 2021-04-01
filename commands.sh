#!/bin/bash

# This searches your history for git commands:
history | grep 'git'

# -E: extended regulat expression
echo grey | grep -E 'gr(a|e)y'

# if statement:
if echo '42' | grep -Ewq '\d{2}'; then echo true; fi

# Use basic flags

# Running this command inside the root of the example directory searches the file text.txt for lines that include the pattern ‘time’,
grep 'time' quotes.txt

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

# Use grep to search within nested files

# `-r` and `-R` recursively search every file in a directory.
grep -ri panic .

# in a git repository use git grep and a .gitignore file to exclude files and folders from your grep
echo ./.git > .gitignore
git grep -ri panic .

# Use a regular expression to search only  “.txt” files
grep -ri panic *.txt

# Work with grep and regular expressions

# get all the non epmty non comment lines
grep -Ev "^$|^#" commands.sh

# get only "ERROR" messages from example.log
grep "ERROR" example.log

# get "ERROR" messages and stack traces from example.log
grep -E 'ERROR|^\D' example.log

# get only "ERROR" messages from example.log with "critical" in the description
grep -E "ERROR.*(c|C)ritical" example.log

# Use grep with pipes and redirects

# counts the occurrences of “ERROR” in the example.log 
grep -o "ERROR" example.log | wc -w

# use -f to include patters from match.txt and exculde patterns from ignore.txt
grep -f patterns/match.txt ./example.log | grep -vf patterns/ignore.txt

# search the log file for only the “WARNING” and “ERROR” message that occurred in the four minute window between 8:45 and 8:49 AM
grep -E "08:4(5|6|7|8)" example.log | grep -Ev "INFO|CONFIG"

# create a new file, errors.log with the errors and stack traces from example.log
grep -E 'ERROR|^\D' example.log > errors.log

# Use a temporary file to rewrite example.log to remove "INFO" messages
grep -v INFO example.log > temp
mv temp example.log


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
