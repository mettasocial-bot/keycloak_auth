# This is a graphql project that uses [Hasura](https://www.hasura.io) and [serverless](https://www.serverless.com)

Table of Contents
1. [To run serverless functions on local machine](#to-run-serverless-functions-on-local-machine)
1. [Docker sanitization Best practices](#docker-sanitization-best-practices)

## To run serverless functions on local machine

#### Requirements
1. [Serverless Cli](https://www.serverless.com/framework/docs/getting-started#install-as-a-standalone-binary)
2. [AWS cli](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
3. Nodejs (>=12.X) 
    - As a best practice install node [via nvm](https://github.com/nvm-sh/nvm#installing-and-updating) 
    - if you dont want nvm use [official site here](https://nodejs.org/en/download/)

#### How to run
1. `npm install`
1. `npm run watch:serverless` This will start all apis on http://localhost:4000

## Docker sanitization Best practices
Run following command once in a while 
```
docker stop $(docker ps -a -q) 
docker rmi -f $(docker images --filter "dangling=true" -a -q) 
docker container prune -f 
docker volume prune
```