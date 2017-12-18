# !/bin/sh

set -e
# set -x

inputdir=$1

basepath=$(cd `dirname $0`;pwd)

inputf="${inputdir}/trtext.txt"

to="zh"

process="0"
if [[ -f "${inputdir}/.process" ]]; then
	process="$(cat "${inputdir}/.process")"
fi
echo "process=${process}"

tail -n +${process} ${inputf} | while read l;do
	process="$((++process))"

	f="${l/\#*/}";
	n="${l#*\#}";
	str="${n#*\#}"
	n="${n%%\#*}";

	translated="$(${basepath}/trans.sh -t ${to} ${str})"

	soundmark=$(echo -e "${translated}" | sed -n 2p)
	trcontent=$(echo -e "${translated}" | sed -n 4p)

	echo -e "${process}: [${f}+${n}]\n#[${str}${soundmark}=>${trcontent}]";

	# # skip translated
	# sed -n ''$n'p' "$f"
	# sed -e ''$n's#//GGT>.*$##' -i "$f"
	# google translate
	sed -e ''$n's#$#'"//GGT>${soundmark}=>${trcontent}"'#' -i "$f"

	echo "${process}" > "${inputdir}/.process"

done
