#!/bin/sh

APPID=X5OVmxuKqQDZ43ibTIwdTmrJN15RTEzjbFAP74yJ
APIKEY=M0urYzNLTgr03flOxiqiCvuUhauXXQUAkfGFaTy2
OBJID=D37YkD7xiX

curl -X POST \
	-H "X-Parse-Application-Id: $APPID" \
	-H "X-Parse-REST-API-Key: $APIKEY" \
	-H "Content-Type: application/json" \
	-d '{"objectId":"'$OBJID'"}' \
	https://api.parse.com/1/functions/NestedActivity

