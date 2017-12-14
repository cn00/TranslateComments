# !/bin/sh

# usage: path/to/main.sh dir [f]

inputdir=$1
force=$2

if [[ "${force}"x == "fx" ]]; then
	echo "0" > "${inputdir}/.process"
fi

basepath=$(cd `dirname $0`;pwd)

${basepath}/getjp.sh ${inputdir}

${basepath}/tr.sh ${inputdir}