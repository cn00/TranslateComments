# !/bin/sh

set -e
# set -x

inputdir=$1

basepath=$(cd `dirname $0`;pwd)

inputf="${inputdir}/jptext.txt"

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

	translated="$(${basepath}/trans.sh -t zh ${str})"

	soundmark=$(echo -e "${translated}" | sed -n 2p)
	trcontent=$(echo -e "${translated}" | sed -n 4p)

	echo -e "${process}: [${f}+${n}]\n#[${str}${soundmark}=>${trcontent}]";

	sed -e ''$n's#$#'"//${soundmark}=>${trcontent}"'#' -i "$f"

	echo "${process}" > "${inputdir}/.process"

done
