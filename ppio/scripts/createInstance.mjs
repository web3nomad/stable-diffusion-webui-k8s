import { post } from './request.mjs'

const imageAuth = process.env.IMAGE_AUTH;

const instances = {
  "dev": {
    name: "机器学习平台",
    productId: "23",
    clusterId: "22",
    networkStorageId: "fs-2SEgwSx7coKjPKE2C8Squ7",
    imageAuth: "",
    imageUrl: "image.paigpu.com/prod-gpucloudpublic/cuda:12.2.2-devel-ubuntu22.04",
    ports: "22,3000,4000,8000,8080,8888,7860",
  },
  "yum-3090": {
    name: "YUM ComfyUI",
    productId: "23",
    clusterId: "22",
    networkStorageId: "fs-B7x768uRvLYJUW4Ev6ijpM",
    imageAuth: imageAuth,
    imageUrl: "image.paigpu.com/prod-htrwqusyqkkyvzawouyy/comfyui:cdb636f",
    ports: "7860",
  },
  "yum-4090": {
    name: "YUM ComfyUI",
    productId: "75",
    clusterId: "26",
    networkStorageId: "fs-oU4n7uWn5D6F4ZtXnaiXPD",
    imageAuth: imageAuth,
    imageUrl: "image.paigpu.com/prod-htrwqusyqkkyvzawouyy/comfyui:cdb636f",
    ports: "7860",
  },
}

function main() {
  const gpuName = process.argv[2];
  var body = {
    gpuNum: 1,
    diskSize: 100,
    billingMode: "afterusage",
    envs: [],
    networkStorageMountPoint: "/data",
    ...instances[gpuName],
  };

  post("/v1/gpu/instance/create", body).then(console.log)
}

main();
