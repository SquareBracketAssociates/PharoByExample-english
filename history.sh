#! /bin/sh
#
# Extract history from chapters -- run "make history"

files=`fgrep '\input' PBE[12].tex | \
perl -p -e 's/.*\\input{([^}]*)}.*/\1/g;'`

for arg in ${files}
do
	echo "===== $arg =========="
	echo ""
	sed -n -e '/HISTORY/,/^$/p;' $arg
done
