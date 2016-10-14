#!/bin/bash

case "$REMUX_VPID" in
''|0|1) CONTENTTYPE='audio/mpeg';;
*) CONTENTTYPE='video/mpeg';;
esac

if [ "$SERVER_PROTOCOL" = HTTP ]; then
  echo -ne "Content-type: ${CONTENTTYPE}\r\n"
  echo -ne '\r\n'
  # abort after headers
  [ "$REQUEST_METHOD" = HEAD ] && exit 0
fi

ffmpeg -y -i - -dn -ignore_unknown -c copy -map 0 -f mpegts - 2>/tmp/externremux.$$
