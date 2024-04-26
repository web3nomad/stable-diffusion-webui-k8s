import crypto from "crypto";
import dotenv from "dotenv";
dotenv.config();

const appid = process.env.APPID;
const appkey = process.env.APPKEY;
const imageAuth = process.env.IMAGE_AUTH;

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
  console.log(nonce, timestamp, signature);
  return { nonce, timestamp, signature };
}

async function get(url) {
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
  console.log(JSON.stringify(data, null, 2));
  return data;
}

function createInstance() {
  const url = "https://openapi.paigpu.com/openapi/v1/gpu/instance/create";
  const { nonce, timestamp, signature } = createSignature(url);
  const myHeaders = new Headers();
  myHeaders.append("X-Appid", appid);
  myHeaders.append("X-Nonce", nonce);
  myHeaders.append("X-Timestamp", timestamp);
  myHeaders.append("X-Signature", signature);
  myHeaders.append("Content-Type", "application/json");

  var raw = JSON.stringify({
    name: "RTX 3090 24GB",
    productId: "23",
    gpuNum: 1,
    diskSize: 100,
    billingMode: "afterusage",
    imageUrl: "image.paigpu.com/prod-htrwqusyqkkyvzawouyy/comfyui:cdb636f",
    imageAuth: imageAuth,
    ports: "7860",
    envs: [],
    clusterId: "22",
    networkStorageId: "fs-B7x768uRvLYJUW4Ev6ijpM",
    networkStorageMountPoint: "/data",
  });

  var requestOptions = {
    method: "POST",
    headers: myHeaders,
    body: raw,
    redirect: "follow",
  };

  fetch(url, requestOptions)
    .then((response) => response.text())
    .then((result) => console.log(result))
    .catch((error) => console.log("error", error));
}

function main() {
  // request('https://openapi.paigpu.com/openapi/v1/clusters');
  // request('https://openapi.paigpu.com/openapi/v1/products?clusterId=22&productName');  // 西北
  // request('https://openapi.paigpu.com/openapi/v1/images?type=private');
  // request('https://openapi.paigpu.com/openapi/v1/networkstorages/list');
  createInstance();
}

main();
