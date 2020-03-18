FROM jboss/keycloak:latest
COPY meraklis /opt/jboss/keycloak/themes/meraklis
COPY docker-entrypoint.sh /opt/jboss/tools
ENTRYPOINT [ "/opt/jboss/tools/docker-entrypoint.sh" ]
CMD ["-b" "0.0.0.0"]


