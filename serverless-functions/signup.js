import fetch from "node-fetch";
import jwt_decode from "jwt-decode";

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
  try {
    const requestData = JSON.parse(event.body);
    const { firstName, lastName, contactNumber, password, email } = requestData;
    if (!email || !password || !contactNumber || !lastName || !firstName) {
      throw new Error("Bad request data");
    }
    let res = await fetch(
      `https://open.kickbox.com/v1/disposable/${email.split("@")[1]}`
    );
    const { disposable } = await res.json();
    if (disposable) {
      throw new Error("Bad Email address");
    }
    try {
      res = await fetch(
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
        "https://auth.mettasocial.com/auth/admin/realms/mettasocial-platform/users",
        {
          headers: {
            Authorization: `Bearer ${access_token}`,
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            firstName: firstName,
            lastName: lastName,
            attributes: {
              type: 8,
              contactNumber: contactNumber,
            },
            credentials: [
              {
                value: password,
                temporary: false,
              },
            ],
            enabled: true,
            emailVerified: true,
            email: email,
          }),
          method: "POST",
        }
      );
      if (+res.status !== 201) {
        console.log(res.status);
        console.log(res);
        const userCreationResponse = await res.json();
        throw new Error(userCreationResponse.errorMessage);
      }
      logoutAdmin(access_token);
      return {
        statusCode: 201,
        body: JSON.stringify({
          message: "signup success",
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
  } catch (e) {
    console.log("error", e);
    console.log("error", event);
    return {
      statusCode: 400,
      body: JSON.stringify({
        message: e.message,
      }),
    };
  }
}
