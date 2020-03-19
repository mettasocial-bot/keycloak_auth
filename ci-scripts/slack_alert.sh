#!/bin/bash
message="Build failed on project ${CI_PROJECT_TITLE} and $1 Environment. Last commit by user ${GITLAB_USER_NAME}"
json="{'text': '${message}'}"
curl -X POST -H 'Content-type: application/json' --data "${json}" ${SLACK_WEBHOOK_URL}