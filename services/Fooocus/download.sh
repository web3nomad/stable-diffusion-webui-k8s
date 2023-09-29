#!/bin/bash

set -Eeuo pipefail

aria2c -x 10 --disable-ipv6 --input-file /docker/links.txt --dir /data --continue
