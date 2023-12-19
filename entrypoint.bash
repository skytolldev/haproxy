#! /bin/bash
set -euxE
LETCD="/usr/local/etc/haproxy"
CONFD="${LETCD}/conf.d"
DATAD="/srv/data/haproxy"

if ! [[ -n $(ls -1A ${CONFD}) ]]; then
  echo "ERROR: there are no configuration files to be included in directory: '${CONFD}' " >&2
  exit 100
fi

if ! [[ -d ${DATAD} ]]; then mkdir -p "${DATAD}"; fi
chmod ug=rwX,o-rX -R "${DATAD}"

exec /usr/sbin/haproxy -W -db -q -f "/usr/local/etc/haproxy/haproxy.cfg" -f "${CONFD}"
