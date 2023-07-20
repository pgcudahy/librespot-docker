# librespot-docker

## Docker container for https://github.com/librespot-org/librespot

Aims to be simple and easy to use.

## Docker compose example

```yaml
version: '3.7'
services:
    librespot:
        image: ghcr.io/pgcudahy/librespot-docker:latest
        container_name: librespot
        restart: unless-stopped
        network_mode: host
        environment:
            - LIBRESPOT_NAME=Librespot
            - LIBRESPOT_USERNAME=spotify_username
            - LIBRESPOT_PASSWORD=spotify_password
            - LIBRESPOT_BITRATE=320
            - LIBRESPOT_VERBOSE=false
            - LIBRESPOT_PROXY=
```
