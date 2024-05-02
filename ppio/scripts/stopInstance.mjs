import { get, post } from "./request.mjs";

function main() {
  const endpoint = process.argv[2];
  get("/v1/gpu/instances").then((data) => {
    const instance = data.instances.find((item) => {
      return (
        item.portMappings.length > 0 &&
        item.portMappings[0].endpoint === endpoint
      );
    });
    console.log("instance", instance);
    post("/v1/gpu/instance/stop", { instanceId: instance.id }).then(console.log);
  });
}

main();
