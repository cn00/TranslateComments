# !/bin/sh

set -e

inputdir=$1

basepath=$(cd `dirname $0`;pwd)
inputf="${inputdir}/jptext.txt"

rm -f "${inputf}"
rm -f "${inputf}.tmp"

grep --include=*.cs --include=*.cc  --include=*.cpp --include=*.php --include=*.js --exclude=*.min.js \
 -e "[^][[:space:]0-9a-zA-Z+=|_;,./:\"\>\<? ©@$&)(}{ -\*]\+" -rn ${inputdir} | tee -a "${inputf}.tmp" | 
sed -f "${basepath}/sed.sed" |
# grep -e "[^][[:space:]0-9a-zA-Z+=|_;,./:\"\>\<? ©@$&)(}{ -\*^]\+" |
sed -e "/^[][0-9a-zA-Z_;:\"\',\.\/\>\<\?\~\`\!©\@\#\$\%\&\*)(+=\|\\}{ -\^]\+$/d" |
while read l;do
	f="${l/:*/}";
	n="${l#*: }";
	rest="${n#* : }"
	rest="${rest//[\/ ,a-zA-Z0-9_><.+= -:;\[\]\']/}"
	n="${n%%:*}";

	echo "${f}#${n}#${rest}" >> "${inputf}";

	echo -ne "\033[s\033[K$((++i))\033[u"
done

echo ""

# sed -e "/^[][0-9a-zA-Z_;:\"\',\.\/\>\<\?\~\`\!©\@\#\$\%\&\*)(+=\|\\}{ -\^]\+$/d" -i "${inputf}"
