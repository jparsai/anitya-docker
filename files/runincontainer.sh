#!/bin/bash

THISDIR=`dirname $0`

source ${THISDIR}/anitya-env.sh

python runserver.py --host '0.0.0.0'
