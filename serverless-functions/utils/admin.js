import { jwt_decode } from "jwt-decode";
import fetch from "node-fetch";
export async function getAdminToken() {
  const res = await fetch(
    `https://staging-auth.mettasocial.com/auth/realms/mettasocial-platform/protocol/openid-connect/token`,
    {
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: `client_id=admin-cli&grant_type=password&scope=openid&username=${process.env.KEYCLOAK_ADMIN_USERNAME}&password=${process.env.KEYCLOAK_ADMIN_PASSWORD}`,
      method: "POST",
    }
  );
  const { access_token } = await res.json();
  return access_token;
}

export async function logoutAdmin(access_token) {
  await fetch(
    `https://staging-auth.mettasocial.com/auth/admin/realms/mettasocial-platform/users/${
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
