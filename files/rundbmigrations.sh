#!/bin/bash
set -xe

echo "Starting database migration ..."

pushd /src/
source anitya-env.sh
python <<\EOF
import os
import anitya.lib

anitya.lib.init(
    os.getenv('ANITYA_DB_URL'),
    '/src/alembic.ini',
    debug=True,
    create=True
)
EOF
popd
