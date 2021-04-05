## Descriptions

Dockerized mGBA.

https://github.com/mgba-emu/mgba

https://hub.docker.com/r/banhcanh/docker-mgba

Use linuxserver's ubuntu focal base image.

## Features

Most features from: https://github.com/mgba-emu/mgba

BUT with: 

- Accessible from browser
- No sound for now
- Probably poor performance (rely exclusively on CPU for now)
- Some glitch/artifacts

## Docker
```yaml
---
version: "2.1"
services:
  mgba:
    image: banhcanh/docker-mgba
    container_name: mgba
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Paris
      - UMASK=022 #optional
    ports:
      - 6180:6180
    volumes:
      - /path/to/config:/config
      - /path/to/rom.gba:/roms/rom.gba
    restart: unless-stopped
```

## License
[MIT](https://choosealicense.com/licenses/mit/)
