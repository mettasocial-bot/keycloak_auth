/**
 * Available variables:
 * user - the current user
 * realm - the current realm
 * token - the current token
 * userSession - the current userSession
 * keycloakSession - the current keycloakSession
 */

var allowedRoles = ["ngo"];

var currentUserRole = "ngo";
var userType = user.getAttribute("type") && user.getAttribute("type")[0];

if (+userType === 2) {
  token.setOtherClaims("https://hasura.io/jwt/claims", {
    "x-hasura-user-id": user.getId(),
    "x-hasura-allowed-roles": Java.to(allowedRoles, "java.lang.String[]"),
    "x-hasura-default-role": currentUserRole,
  });
} else {
  token.setOtherClaims("https://hasura.io/jwt/claims", {});
}
