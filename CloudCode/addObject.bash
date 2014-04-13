#!/bin/bash

# arg1 = number of activity to add.

curl -X POST   -H "X-Parse-Application-Id: X5OVmxuKqQDZ43ibTIwdTmrJN15RTEzjbFAP74yJ"   -H "X-Parse-REST-API-Key: M0urYzNLTgr03flOxiqiCvuUhauXXQUAkfGFaTy2"   -H "Content-Type: application/json"   -d "{\"number\":$1}"   https://api.parse.com/1/functions/AddNewActivity
