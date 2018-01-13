## Prerequisites

- [Packer](https://www.packer.io/downloads.html)
- [Vagrant](https://www.vagrantup.com/downloads.html)
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

## Usage

This repository contains a [Packer Template](https://www.packer.io/docs/templates/index.html) to create a machine image using the Ubuntu 16.04.3 LTS (Xenial Xerus) server disk image. The machine image contains the following software:

| Name                                     | Description                                                                                                        |
|------------------------------------------|--------------------------------------------------------------------------------------------------------------------|
| [Consul](https://www.consul.io/)         | A distributed, highly available system                                                                             |
| [Nomad](https://www.nomadproject.io/)    | A single binary that schedules applications and services on Linux, Windows, and Mac                                |
| [Vault](https://www.vaultproject.io/)    | A Tool for Managing Secrets                                                                                        |
| [Elastic Stack](https://www.elastic.co/) | Reliably and securely take data from any source, in any format, and search, analyze, and visualize it in real time |

### Using Packer

To generate a machine image using Packer, use the [`build`](https://www.packer.io/docs/commands/build.html) command. The packer build command takes a template and runs all the builds within it to generate a set of artifacts.

	$ packer build 16.04.3-server-amd64.json

To enable the logger during the `build` process, set the `PACKER_LOG` environment variable to any value other than "" (empty string) or "0".

	$ PACKER_LOG=1 packer build 16.04.3-server-amd64.json

## License

[pennsignals](https://github.com/pennsignals) @ [MIT](https://github.com/pennsignals/packer-templates/blob/master/LICENSE)
