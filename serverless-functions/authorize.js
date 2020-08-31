import https from "https";
import querystringParser from "querystring";
import jwt_decode from "jwt-decode";

const USER_TYPE_ENUM_TO_APP_URL_NAME = {
  1: "admin",
  2: "npo",
  4: "corp",
};

const USER_TYPE_ENUM_TO_LOCAL_PORT = {
  1: 3002,
  2: 3000,
  4: 3001,
};

function getRedirectBaseUrl(APP_ENV, USER_TYPE) {
  if (APP_ENV === "local-") {
    return `http://localhost:${USER_TYPE_ENUM_TO_LOCAL_PORT[USER_TYPE]}`;
  }
  return `https://${APP_ENV}${USER_TYPE_ENUM_TO_APP_URL_NAME[USER_TYPE]}.meraklis.in`;
}

export async function index(event) {
  let response = {};
  let redirect_path = event.path.replace("/authorize", "");
  let authorization_code = event.queryStringParameters.code;

  if (
    !event.headers ||
    !(event.headers.Referer || event.headers.referer) ||
    !event.queryStringParameters ||
    !event.queryStringParameters.code
  ) {
    response = {
      statusCode: 400,
      body: JSON.stringify("Bad Request!"),
    };
    return response;
  }
  try {
    let parsedURL = new URL(event.headers.Referer || event.headers.referer);
    let APP_ENV = "";
    const origin = parsedURL.host;
    const searchString = parsedURL.search;
    if (searchString) {
      const queryString = searchString.replace("?", "");
      let clientId = querystringParser.parse(queryString).client_id;
      if (!clientId.match(/^(local|dev|staging)?-?meraklis$/)) {
        return {
          statusCode: 400,
          body: JSON.stringify("Bad Request!"),
        };
      }
      APP_ENV = clientId.replace("meraklis", "");
    } else {
      if (origin.match(/^localhost/)) {
        APP_ENV = "local-";
      } else if (origin.match(/^(dev|staging)?-?www.meraklis.in$/)) {
        APP_ENV = origin.replace("www.meraklis.in", "");
      }
    }
    let token_data = await getToken({
      authorization_code,
      APP_ENV,
      redirect_path,
    });
    const USER_TYPE = jwt_decode(token_data.access_token).user_type;
    response = {
      statusCode: 302,
      headers: {
        location: `${getRedirectBaseUrl(APP_ENV, USER_TYPE)}${redirect_path}`,
      },
    };
  } catch (e) {
    console.log("error", JSON.stringify(e));
    console.log("error", event);
    response = {
      statusCode: 302,
      headers: {
        location: "https://www.meraklis.in?error=500",
      },
    };
  }
  return response;
}

function getToken({ authorization_code, APP_ENV, redirect_path }) {
  return new Promise((resolve, reject) => {
    const data = `code=${authorization_code}&grant_type=authorization_code&client_id=${APP_ENV}meraklis&redirect_uri=https://authz.meraklis.in/authorize${redirect_path}`;
    console.log(data);
    const options = {
      hostname: `auth.meraklis.in`,
      port: 443,
      path: "/auth/realms/meraklis-platform/protocol/openid-connect/token",
      method: "POST",
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Content-Length": data.length,
      },
    };
    const req = https
      .request(options, (res) => {
        let data = "";
        res.on("data", (chunk) => {
          data += chunk;
        });
        res.on("end", () => {
          console.log(data, "token");
          resolve(JSON.parse(data));
        });
      })
      .on("error", (err) => {
        reject(err);
      });

    req.write(data);
    req.end();
  });
}
