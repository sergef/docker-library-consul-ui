# Docker images

## Consul Web UI

Builds and hosts release version of Consul Web UI.
Proxy should take care of `/v1` location to point to Consul container hosting the API.

Read more https://github.com/hashicorp/consul/tree/master/ui.

### Build arguments

**CONSUL_VERSION**

Repository tag to build, default value 'v0.9.2',
depends on package version available in Alpine:
https://pkgs.alpinelinux.org/packages?name=consul&branch=&repo=&arch=&maintainer=

### Warnings

`json 1.8.2` gem is not compatible with Ruby 2.4 installed by default in Alpine linux Edge,
therefore using Ruby 2.3.3 and other packages from Alpine linux v3.5.
