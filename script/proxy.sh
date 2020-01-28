#!/bin/sh

# Since we can't open TCP ports on Heroku, we need to forward traffic to a proxy server that
# permits incoming connections
# Resources for setting up the proxy server: https://github.com/kaboomserver/proxy

rtun
