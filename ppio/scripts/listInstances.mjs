import { get } from './request.mjs'

function main() {
  const name = process.argv[2];
  get('/v1/gpu/instances').then(data => {
    const items = data.instances
      .filter(item => item.status === 'running')
      .filter(item => item.imageName === 'image.paigpu.com/prod-htrwqusyqkkyvzawouyy/comfyui:cdb636f')
      .filter(item => item.name.includes(name))
      .map((item) => {
        const { name, sshCommand, rootPassword, portMappings } = item;
        return {
          name,
          sshCommand,
          rootPassword,
          portMapping: portMappings[0],
        }
      });
    console.log(items.map(item => 'http://' + item.portMapping.endpoint).join(','));
  })
}

main();
