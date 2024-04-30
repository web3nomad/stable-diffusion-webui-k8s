import { post } from './request.mjs'

const imageAuth = process.env.IMAGE_AUTH;

const instances = {
  "3090": {
    name: "RTX 3090 24GB",
    productId: "23",
    clusterId: "22",
    networkStorageId: "fs-B7x768uRvLYJUW4Ev6ijpM",
  },
  "4090": {
    name: "RTX 4090 24GB",
    productId: "70",
    clusterId: "26",
    networkStorageId: "fs-oU4n7uWn5D6F4ZtXnaiXPD",
  },
}

function main() {
  const gpuName = process.argv[2];
  var body = JSON.stringify({
    gpuNum: 1,
    diskSize: 100,
    billingMode: "afterusage",
    imageUrl: "image.paigpu.com/prod-htrwqusyqkkyvzawouyy/comfyui:cdb636f",
    imageAuth: imageAuth,
    ports: "7860",
    envs: [],
    networkStorageMountPoint: "/data",
    ...instances[gpuName],
  });

  post("/v1/gpu/instance/create", body).then(console.log)
}

main();
