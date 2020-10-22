/*
 * Template for JavaScript based authenticator's.
 * See org.keycloak.authentication.authenticators.browser.ScriptBasedAuthenticatorFactory
 */

// import enum for error lookup
AuthenticationFlowError = Java.type(
  "org.keycloak.authentication.AuthenticationFlowError"
);

/**
 * An example authenticate function.
 *
 * The following variables are available for convenience:
 * user - current user {@see org.keycloak.models.UserModel}
 * realm - current realm {@see org.keycloak.models.RealmModel}
 * session - current KeycloakSession {@see org.keycloak.models.KeycloakSession}
 * httpRequest - current HttpRequest {@see org.jboss.resteasy.spi.HttpRequest}
 * script - current script {@see org.keycloak.models.ScriptModel}
 * authenticationSession - current authentication session {@see org.keycloak.sessions.AuthenticationSessionModel}
 * LOG - current logger {@see org.jboss.logging.Logger}
 *
 * You one can extract current http request headers via:
 * httpRequest.getHttpHeaders().getHeaderString("Forwarded")
 *
 * @param context {@see org.keycloak.authentication.AuthenticationFlowContext}
 */
Response = Java.type("javax.ws.rs.core.Response");
function authenticate(context) {
  LOG.info(
    script.name +
      " trace auth for: " +
      httpRequest.getHttpHeaders().getRequestHeader("referer")
  );
  referer = httpRequest.getHttpHeaders().getRequestHeader("referer")[0];
  if (
    referer &&
    (referer.startsWith("https://staging-www.mettasocial.com") ||
      referer.startsWith("https://dev-www.mettasocial.com") ||
      referer.startsWith("https://www.mettasocial.com") ||
      referer.startsWith("https://demo.mettasocial.com") ||
      referer.startsWith("http://localhost:3000") ||
      referer.startsWith("http://localhost:8000"))
  ) {
    context.success();
    return;
  }
  var challengeResponse = context
    .form()
    .setError(
      '<strong class="text-info">You seem to not have beta invite.</strong>'
    )
    .createErrorPage(Response.Status.INTERNAL_SERVER_ERROR);
  context.failure(AuthenticationFlowError.CLIENT_DISABLED, challengeResponse);
  return;
}
