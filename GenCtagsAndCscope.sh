#!/bin/sh

abs_trace_root=${1}
abs_trace_root=${abs_trace_root:?"Please give trace root (\$1) of absolute path."}

find_default_opt="-name *.c -o -name *.h -o -name *.S -o -name *.s -o -name *.asm -o -name *.cpp -o -name *.hs"

# <TODO>
#find_opt="$abs_trace_root"
#if [ $# -eq 1 ]; then
#    find_cmd="${find_opt} ${find_default_opt}"
#else
#    shift 1
#    for var in ${@}
#    do
#        find_opt=${var} ${find_opt}
#    done
#fi
#echo $find_cmd

# cscope
find ${abs_trace_root} ${default_opt} > cscope.files &&
cscope -Rbq cscope.files

# ctags
# Specify some excluding patterns althoung some are excluded default 
ctags -R \
    --exclude=.svn \
    --exclude=.git \
    --exclude=*.url \
    --exclude=*.htm \
    --exclude=*.txt \
    $abs_trace_root

