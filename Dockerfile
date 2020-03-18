FROM jboss/keycloak:latest
USER root
COPY meraklis /opt/jboss/keycloak/themes/meraklis
COPY docker-entrypoint.sh /opt/jboss/tools
RUN chmod 0777 /opt/jboss/tools/docker-entrypoint.sh
ENTRYPOINT [ "/opt/jboss/tools/docker-entrypoint.sh" ]
CMD ["-b", "0.0.0.0"]



