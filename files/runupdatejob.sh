#!/bin/bash -x

THISDIR=`dirname $0`

source ${THISDIR}/anitya-env.sh
export PYTHONPATH=${THISDIR}
while :; do
  python ${THISDIR}/files/anitya_cron.py --check-feed --by-ecosystem
  sleep ${WAIT_SECONDS:-60}
done
