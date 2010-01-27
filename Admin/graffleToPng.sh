#!/bin/bash
#
# call Omnigraffle to convert figures to PNG
# do an export by hand first, to check the correct resolution (300dpi)
# and export settings (all objects, no transparent background)


params=`getopt dn $*`
[ $? == 0 ] || { echo Usage: `basename $0` [-n] [-f] [-d] [searchRootDir]; exit 1; }
set -- ${params/--}
for param; do
   case $param in
      -n) dryRun=echo;;
      -f) overwrite=true;;
      -d) deletePdfs=true;;
      *) searchRootDir=$param;;
   esac
done

SCRIPT=`dirname $0`
for f in `find "${searchRootDir:=.}" -name \*.graffle`; do
   dest="${f/%.graffle/.png}"
   if [ -f "$dest" ]; then
      echo "Already exists: $dest"
   else
      echo "To convert: $f"
   fi
   [ ! -f "$dest" -o "$overwrite" ] && ${dryRun} ${SCRIPT}/graffle2pdf "$f" "${dest}"
   [ "$deletePdfs" ] && ${dryRun} rm "${f/%.graffle/.pdf}"
done
