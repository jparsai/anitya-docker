#!/bin/bash

THISDIR=`dirname $0`

source ${THISDIR}/anitya-env.sh
exec mod_wsgi-express start-server /src/anitya.wsgi --port 5000 --host 0.0.0.0 --user apache --group apache --access-log --access-log-format "%h %l %u %t \"%r\" %>s %b %{Referer}i \"%{User-agent}i\"" --log-to-terminal
