FROM jboss/keycloak:11.0.0
USER root
COPY keycloak-custom-theme/meraklis /opt/jboss/keycloak/themes/meraklis
COPY docker-entrypoint.sh /opt/jboss/tools
RUN chmod 0777 /opt/jboss/tools/docker-entrypoint.sh
ENTRYPOINT [ "/opt/jboss/tools/docker-entrypoint.sh" ]
EXPOSE 80
EXPOSE 9990
CMD ["-b", "0.0.0.0"]