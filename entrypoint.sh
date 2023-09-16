#!/bin/sh

export GTS_PORT=$PORT

exec ./gotosocial --config-path ./config.yaml $*
