## Descriptions

Dockerized mGBA.

https://github.com/mgba-emu/mgba

https://hub.docker.com/r/banhcanh/docker-mgba

Use linuxserver's ubuntu focal base image.

Controls:
- Use arrows to move.
- To press button A, use W
- To press button B, use Z
- To press buttons L and R, use Q and S
- To press start and select, use return key and backspace

## Features

Most features from: https://github.com/mgba-emu/mgba

BUT with: 

- Accessible from browser
- No sound for now
- Probably poor performance (rely exclusively on CPU for now)
- Some glitch/artifacts
- Auto-start your rom.gba (see below)

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
      - /path/to/roms:/roms
    restart: unless-stopped
```
## Screenshot

![image](https://user-images.githubusercontent.com/66330398/113675850-10837200-96bc-11eb-9841-6b2b4dca0ed2.png)


## License
[MIT](https://choosealicense.com/licenses/mit/)
