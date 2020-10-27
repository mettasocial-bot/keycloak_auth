#!/bin/bash
if [[ $2 -eq 0 ]]
    then
        message="{
			'channel': '${SLACK_BUILD_MONITOR_CHANNEL_ID}',
			'attachments': [
				{
					'color': '#FF0000',
					'pretext': 'Last build failed on project ${CI_PROJECT_TITLE}',
					'title': 'Build failed on project ${CI_PROJECT_TITLE} on $1 Environment',
					'title_link': '${CI_PROJECT_URL}',
					'fields': [
						{
							'title': 'Last commit by',
							'value': '${GITLAB_USER_NAME}',
							'short': true
						},
						{
							'title': 'Hey ${GITLAB_USER_NAME} A request...',
							'value': 'Please fix this ASAP :sweat:',
							'short': true
						},
						{
							'title': 'Check the pipeline link below for more details',
							'value': '${CI_PIPELINE_URL}',
							'short': false
						},
						{
							'title': 'Last commit message Says',
							'value': '$(echo ${CI_COMMIT_MESSAGE} | xargs)',
							'short': false
						}
					],
					'footer': 'Metta Social Solutions Pvt. Ltd.',
					'footer_icon': 'https://cdn.mettasocial.com/logos/64_without_name_color.png',
					'ts': '$EPOCHSECONDS'
				}
			]
		}"
    else if [[ $2 -eq 1 ]]
    then  
        message="{
			'channel': '${SLACK_BUILD_MONITOR_CHANNEL_ID}',
			'attachments': [
				{
					'color': '#36a64f',
					'pretext': 'Last build Succeeded on project ${CI_PROJECT_TITLE}',
					'title': 'Build Succeeded on project ${CI_PROJECT_TITLE} on $1 Environment',
					'title_link': '${CI_PROJECT_URL}',
					'fields': [
						{
							'title': 'Last commit by',
							'value': '${GITLAB_USER_NAME}',
							'short': true
						},
						{
							'title': 'Cheers to ${GITLAB_USER_NAME}',
							'value': 'You did a great a job. Keep it up!!! :beers: :thumbsup:',
							'short': true
						},
						{
							'title': 'Check the pipeline link below for more details',
							'value': '${CI_PIPELINE_URL}',
							'short': false
						},
						{
							'title': 'Last commit message Says',
							'value': '$(echo $CI_COMMIT_MESSAGE | xargs)',
							'short': false
						}
					],
					'footer': 'Metta Social Solutions Pvt. Ltd.',
					'footer_icon': 'https://cdn.mettasocial.com/logos/64_without_name_color.png',
					'ts': '$EPOCHSECONDS'
				}
			]
		}"
    fi
fi
curl -X POST -H "Content-type: application/json; charset=utf-8;" -H "Authorization: Bearer ${SLACK_BUILDBOT_TOKEN}" --data "${message}" $SLACK_WBEHOOK_URL