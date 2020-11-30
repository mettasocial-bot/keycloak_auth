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

### Running keycloak locally

```

docker build . -t my-keycloak
docker run -e DB_URL=<DB_URL> -e KEYCLOAK_PASSWORD=demoadminpassword -e KEYCLOAK_USER=demoadminuser -e PORT=80 -p 8081:80 -v keycloak-custom-theme/meraklis:/opt/jboss/keycloak/themes/meraklis my-keycloak:latest

```

open `http://localhost:8081`
go to http://localhost:8081/auth/realms/mettasocial-platform/protocol/openid-connect/registrations?client_id=mettasocial-npo&redirect_uri=https%3A%2F%2Fnpo.mettasocial.com&state=4dfa71a3-a257-4812-8d68-83f7b91f0411&response_mode=query&response_type=code&scope=openid&nonce=8d3432f5-259f-45a2-8e28-734c13ead4c3
