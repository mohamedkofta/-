#!/bin/bash
#
# Deploys the app to App Engine.
#
# Note: This script should be used in place of using appcfg.py update directly
# to update the application on App Engine.
#
# Copyright 2015 Eric Bidelman <ericbidelman@chromium.org>


deployVersion=$1
usage="Usage: deploy.sh `date +%Y-%m-%d`"

if [ -z "$deployVersion" ]
then
  echo "App version not specified."
  echo $usage
  exit 0
fi

# The directory in which this script resides.
readonly BASEDIR=$(dirname $BASH_SOURCE)

# vulcanize $BASEDIR/../static/elements/elements.html -o $BASEDIR/../static/elements/elements.vulcanized.html --config vulcanize_config.json

gulp

$BASEDIR/oauthtoken.sh deploy
appcfg.py update -A cr-status -V $deployVersion $BASEDIR/../app.yaml $BASEDIR/../notifier.yaml
