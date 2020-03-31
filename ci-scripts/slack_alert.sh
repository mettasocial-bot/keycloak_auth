#!/bin/bash
if [[ $2 -eq 0 ]]
    then
        message="Build failed on project <${CI_PROJECT_URL}|${CI_PROJECT_TITLE}> and $1 Environment. Last commit by user ${GITLAB_USER_NAME}. <${CI_PIPELINE_URL}|Please check *${CI_PIPELINE_IID}* for more details>"
    else if [[ $2 -eq 1 ]]
    then  
        message="Build succeeded on project <${CI_PROJECT_URL}|${CI_PROJECT_TITLE}> and $1 Environment. Cheers to ${GITLAB_USER_NAME}. You did great job."
    fi
fi
COMMIT_MESSAGE="$(echo $CI_COMMIT_MESSAGE | xargs)"
message="${message}. Last commit message says: *${COMMIT_MESSAGE}*."
finalMessage="{
	'blocks': [
		{
			'type': 'section',
			'text': {
				'type': 'mrkdwn',
				'text': '${message}'
			}
		}
	]
}"
echo ${finalMessage}
curl -X POST -H 'Content-type: application/json' --data "${finalMessage}" https://hooks.slack.com/services/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