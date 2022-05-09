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
    var userType = user.getAttribute("type") && user.getAttribute("type")[0];
    var client = session.getContext().getClient().getClientId();
    var authShouldFail = true;
    if (client.match(/(dev-|staging-)?mettasocial-npo/) && +userType === 2) {
        authShouldFail = false;
    } else if (client.match(/(dev-|staging-)?mettasocial-corp/) && +userType === 4) {
        authShouldFail = false;
    } else if (
        client.match(/(dev-|staging-)?mettasocial-citizen/) &&
        +userType === 8
    ) {
        authShouldFail = false;
    } else if (
        client.match(/(dev-|staging-)?mettasocial-hni/) &&
        +userType === 16
    ) {
        authShouldFail = false;
    } else if (+userType === 1) {
        authShouldFail = false;
    }
    if (authShouldFail) {
        var challengeResponse = context
            .form()
            .setError(
                '<strong class="text-info">You are not authorized to login to this application.</strong>'
            )
            .createErrorPage(Response.Status.INTERNAL_SERVER_ERROR);
        context.failure(AuthenticationFlowError.INVALID_USER, challengeResponse);
        return;
    }
    context.success();
    return;
}