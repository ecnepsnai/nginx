# nginx

This repository provides a modern & slim OCI container image for running nginx. It includes a compiled version of nginx
and OpenSSL.

The image is less than 30MiB for easy storage and portability.

## Usage

### Volumes

- `/nginx_root` - The default root directory
- `/nginx_conf` - Directory for additional configuration files to be included on startup
- `/usr/local/nginx/logs` - Directory for NGINX logs

### Ports

Exposes 80 and 443
