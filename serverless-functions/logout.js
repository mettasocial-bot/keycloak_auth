import jwt_decode from "jwt-decode";
import fetch from "node-fetch";

function logoutAdmin(access_token) {
  fetch(
    `https://auth.mettasocial.com/auth/admin/realms/mettasocial-platform/users/${
      jwt_decode(access_token).sub
    }/logout`,
    {
      headers: {
        Authorization: `Bearer ${access_token}`,
        "Content-Type": "application/json",
      },
      body: JSON.stringify({}),
      method: "POST",
    }
  );
}
export async function index(event) {
  if (!event.headers.Authorization) {
    console.log(event);
    return {
      statusCode: 400,
      body: JSON.stringify({
        message: "Seems you are not logged in. :(",
      }),
    };
  }
  try {
    const userId = jwt_decode(event.headers.Authorization).sub;
    let res = await fetch(
      `https://auth.mettasocial.com/auth/realms/mettasocial-platform/protocol/openid-connect/token`,
      {
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: `client_id=admin-cli&grant_type=password&scope=openid&username=${process.env.KEYCLOAK_ADMIN_USERNAME}&password=${process.env.KEYCLOAK_ADMIN_PASSWORD}`,
        method: "POST",
      }
    );
    const { access_token } = await res.json();
    res = await fetch(
      `https://auth.mettasocial.com/auth/admin/realms/mettasocial-platform/users/${userId}/logout`,
      {
        headers: {
          Authorization: `Bearer ${access_token}`,
          "Content-Type": "application/json",
        },
        body: JSON.stringify({}),
        method: "POST",
      }
    );
    console.log("object", res, res.statusText, res.status);
    if (res.status !== 204) {
      const logoutResponse = await res.json();
      throw new Error(logoutResponse.errorMessage);
    }
    logoutAdmin(access_token);
    return {
      statusCode: 201,
      body: JSON.stringify({
        message: "Logout success",
      }),
    };
  } catch (e) {
    console.log("error", e);
    console.log("error", event);
    return {
      statusCode: 500,
      body: JSON.stringify({
        message: e.message,
      }),
    };
  }
}
