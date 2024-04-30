import { get } from './request.mjs'

function main() {
  get('/v1/gpu/instances').then(data => {
    const items = data.instances
      .filter(item => item.status === 'running')
      .filter(item => item.imageName === 'image.paigpu.com/prod-htrwqusyqkkyvzawouyy/comfyui:cdb636f')
      .map((item) => {
        const { sshCommand, rootPassword, portMappings } = item;
        return {
          sshCommand,
          rootPassword,
          portMapping: portMappings[0],
        }
      });
    console.log(items.map(item => 'http://' + item.portMapping.endpoint).join(','));
  })
}

main();
