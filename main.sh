# !/bin/sh

inputdir=$1

basepath=$(cd `dirname $0`;pwd)

${basepath}/getjp.sh ${inputdir}

${basepath}/tr.sh ${inputdir}