#!/usr/bin/env bash

COMPOSE="docker-compose"

if [ $# -gt 0 ];then
    if [[ "$1" == "rails" ]]; then
        shift 1
        $COMPOSE run --rm -w /myapp web bin/rails "$@"
    elif [[ "$1" == "bash" ]]; then
        $COMPOSE exec web bash
    elif [[ "$1" == "bundle" ]]; then
        shift 1
        $COMPOSE run --rm -w /myapp web bin/bundle "$@"
    elif [[ "$1" == "restart" ]]; then
        shift 1
        $COMPOSE stop
        $COMPOSE start
    else
        $COMPOSE "$@"
    fi
else
    $COMPOSE ps
fi
