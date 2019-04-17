# Script from Paul Brook, posted in squad-theia chat 16/04/2019

#!/bin/sh

set -e

host=tstat.hm-stage.ecobee.com
prod_host=api.ecobee.com
email=robert.c@ecobee.com
pass=password1234.

refresh_file=/tmp/jwt-refresh-token-$user

if [ "x$1" = "x--refresh" ] || ! [ -f $refresh_file ]; then
  echo "Generating refresh token"
  refresh=$(curl --silent --request POST  --url "https://$host/home/authorize?response_type=ecobeeAuthz&client_id=oDsUbEjw8Qw2cVLBQR4akMV9bsAP6GAC&scope=smartWrite&username=$email&password=$pass&ecobee_type=JWT" | jq -r .refresh_token)
  echo "Got refresh token: $refresh"
  echo "$refresh" > $refresh_file
else
  read refresh < $refresh_file
fi

TOKEN=`curl --silent --request POST  --url "https://$host/home/token?response_type=ecobeeAuthz&client_id=oDsUbEjw8Qw2cVLBQR4akMV9bsAP6GAC&scope=smartWrite&grant_type=refresh_token&refresh_token=$refresh&ecobee_type=JWT"  --header 'Postman-Token: 7a4e82af-2b8e-432d-8b01-436a3ce467d7'  --header 'cache-control: no-cache' | jq -r '.access_token'`
echo $TOKEN | xclip
echo $TOKEN
