import fetch from "node-fetch";
import { getAdminToken, logoutAdmin } from "./utils/admin";

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
    let adminAccessToken = null;
    try {
      adminAccessToken = await getAdminToken();
      res = await fetch(
        "https://staging-auth.mettasocial.com/auth/admin/realms/mettasocial-platform/users",
        {
          headers: {
            Authorization: `Bearer ${adminAccessToken}`,
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
        const userCreationResponse = await res.json();
        throw new Error(userCreationResponse.errorMessage);
      }
      logoutAdmin(adminAccessToken);
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
    } finally {
      adminAccessToken && logoutAdmin(adminAccessToken);
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
