import jwt_decode from "jwt-decode";
import fetch from "node-fetch";
import { getAdminToken, logoutAdmin } from "./utils/admin";

export async function index(event) {
  if (!event.headers.Authorization) {
    return {
      statusCode: 400,
      body: JSON.stringify({
        message: "Seems you are not logged in. :(",
      }),
    };
  }
  let adminAccessToken = null;
  try {
    const userId = jwt_decode(event.headers.Authorization).sub;
    adminAccessToken = await getAdminToken();
    const res = await fetch(
      `https://staging-auth.mettasocial.com/auth/admin/realms/mettasocial-platform/users/${userId}/logout`,
      {
        headers: {
          Authorization: `Bearer ${adminAccessToken}`,
          "Content-Type": "application/json",
        },
        body: JSON.stringify({}),
        method: "POST",
      }
    );
    if (res.status !== 204) {
      const logoutResponse = await res.json();
      throw new Error(logoutResponse.errorMessage);
    }
    logoutAdmin(adminAccessToken);
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
  } finally {
    logoutAdmin(adminAccessToken);
  }
}
