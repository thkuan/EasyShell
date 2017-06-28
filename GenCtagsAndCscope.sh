#!/bin/sh

abs_trace_root=${1}
abs_trace_root=${abs_trace_root:?"Please give trace root (\$1) of absolute path."}

find_default_opt="-name *.c -o -name *.h -o -name *.S -o -name *.s -o -name *.asm -o -name *.cpp -o -name *.hs"

# <TODO> Expect user input argument in ${2}. E.g., patterns *.html *.htm
#if [ $# -eq 1 ]; then
#    find_cmd_opt="${abs_trace_root} ${find_default_opt}"
#else
#    find_cmd_opt="${abs_trace_toot ${find_default_opt}"
#    shift 1
#    for var in ${@}
#    do
#        find_cmd_opt=${find_cmd_opt} ${var}
#    done
#fi
#echo "find $find_cmd_opt"

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

