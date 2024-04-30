import crypto from "crypto";
import dotenv from "dotenv";
dotenv.config();

const appid = process.env.APPID;
const appkey = process.env.APPKEY;

function createSignature(urlString) {
  const nonce = Math.random().toString(36).substring(2, 18);
  const timestamp = Date.now();
  const url = new URL(urlString);
  const path = url.pathname;

  const data = appid + nonce + timestamp + path;
  const signature = crypto
    .createHmac("sha256", appkey)
    .update(data)
    .digest("hex");
  // console.log(nonce, timestamp, signature);
  return { nonce, timestamp, signature };
}

export async function get(url) {
  url = 'https://openapi.paigpu.com/openapi' + url;
  const { nonce, timestamp, signature } = createSignature(url);
  const myHeaders = new Headers();
  myHeaders.append("X-Appid", appid);
  myHeaders.append("X-Nonce", nonce);
  myHeaders.append("X-Timestamp", timestamp);
  myHeaders.append("X-Signature", signature);

  var requestOptions = {
    method: "GET",
    headers: myHeaders,
    redirect: "follow",
  };

  const response = await fetch(url, requestOptions);
  const data = await response.json();
  // console.log(JSON.stringify(data, null, 2));
  return data;
}

export async function post(url, body) {
  url = 'https://openapi.paigpu.com/openapi' + url;
  const { nonce, timestamp, signature } = createSignature(url);
  const myHeaders = new Headers();
  myHeaders.append("X-Appid", appid);
  myHeaders.append("X-Nonce", nonce);
  myHeaders.append("X-Timestamp", timestamp);
  myHeaders.append("X-Signature", signature);
  myHeaders.append("Content-Type", "application/json");

  var requestOptions = {
    method: "POST",
    headers: myHeaders,
    body: body,
    redirect: "follow",
  };

  const response = await fetch(url, requestOptions);
  const data = await response.json();
  // console.log(JSON.stringify(data, null, 2));
  return data;
}
