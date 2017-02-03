#!/bin/bash

THISDIR=`dirname $0`

source ${THISDIR}/anitya-env.sh
export PYTHONPATH=${THISDIR}
exec python ${THISDIR}/files/anitya_cron.py --check-feed
