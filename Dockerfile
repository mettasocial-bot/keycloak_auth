FROM jboss/keycloak:latest
ENV DB_PORT 5432
ENV DB_DATABASE keycloak
ENV DB_USER keycloak
ENV DB_PASSWORD password
ENV DB_VENDOR postgres
ENV DB_ADDR postgres
ENV KEYCLOAK_USER admin
ENV KEYCLOAK_PASSWORD admin
COPY standalone.xml /opt/jboss/keycloak/standalone/standalone.xml
COPY standalone.xml /opt/jboss/keycloak/standalone/configuration/standalone.xml
COPY meraklis /opt/jboss/keycloak/themes/meraklis
COPY docker-entrypoint.sh /opt/jboss/tools
ENTRYPOINT [ "/opt/jboss/tools/docker-entrypoint.sh" ]
CMD [-b, 0.0.0.0:$PORT]


