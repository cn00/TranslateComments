# !/bin/sh

set -e

inputdir=$1

basepath=$(cd `dirname $0`;pwd)
inputf="${inputdir}/jptext.txt"
rm -f "$inputf"

grep --include=*.cs --include=*.cc  --include=*.cpp --include=*.php --include=*.js --exclude=*.min.js \
 -e "[^][[:space:]0-9a-zA-Z+=|_;,./:\"\>\<? ©@$&)(}{ -\*]\+" -rn $inputdir | 
sed -e '/AutoGen/d' |
grep -e "[^][[:space:]0-9a-zA-Z+=|_;,./:\"\>\<? ©@$&)(}{ -\*]\+" |
sed -f "${basepath}/sed.sed" | while read l;do
	f="${l/:*/}";
	n="${l#*: }";
	rest="${n#* : }"
	rest="${rest//[\/ ,a-zA-Z0-9_><.+= -:;\[\]\']/}"
	n="${n%%:*}";

	echo "${f}#${n}#${rest}" >> "${inputf}";
done