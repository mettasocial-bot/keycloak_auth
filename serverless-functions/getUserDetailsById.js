import fetch from "node-fetch";
import { getAdminToken, logoutAdmin } from "../utils/admin";
export async function index(event) {
  try {
    const requestData = JSON.parse(event.body);
    const { id, ids } = requestData;
    if (!id && !ids) {
      throw new Error("Bad request data");
    }
    let idsToFetchData = null;
    if (id) {
      idsToFetchData = [id];
    } else {
      idsToFetchData = ids;
    }
    const adminAccessToken = await getAdminToken();
    const resData = await Promise.all(
      idsToFetchData.map((id) => {
        return fetch(
          `https://auth.mettasocial.com/auth/admin/realms/mettasocial-platform/users/${id}`,
          {
            headers: {
              Authorization: `Bearer ${adminAccessToken}`,
              "Content-Type": "application/json",
            },
            method: "GET",
          }
        );
      })
    );
    const data = await Promise.all(
      resData.map((res) => {
        return res.json();
      })
    );
    logoutAdmin(adminAccessToken);
    return {
      statusCode: 201,
      body: JSON.stringify(data),
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
