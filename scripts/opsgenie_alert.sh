#!/bin/sh
/usr/bin/curl -XPOST 'https://api.opsgenie.com/v1/json/alert' -d '
{
     "apiKey": "[MASKED]",
     "message" : "alert '$1' '$2' '$3'",
     "teams" : ["[MASKED]"]
}'

