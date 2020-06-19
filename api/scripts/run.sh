#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd ${DIR}/../../

rm -f docker-compose.override.yml

docker-compose up -d

docker-compose logs -f

