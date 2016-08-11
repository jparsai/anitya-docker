#!/bin/bash
set -x

THISDIR=`dirname $0`

# /env.sh is created on container startup and we use it to preserve
#    environment variables for this script
source /env.sh
source ${THISDIR}/anitya-env.sh

PYTHONPATH=${THISDIR} python ${THISDIR}/files/anitya_cron.py --check-feed
