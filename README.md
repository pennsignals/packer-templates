This repository contains a [Packer Template](https://www.packer.io/docs/templates/index.html) to create a machine image using the Ubuntu 16.04.3 LTS (Xenial Xerus) server disk image. The machine image contains the following software:

| Name                                     | Description                                                                                                        |
|------------------------------------------|--------------------------------------------------------------------------------------------------------------------|
| [Consul](https://www.consul.io/)         | A distributed, highly available system                                                                             |
| [Nomad](https://www.nomadproject.io/)    | A single binary that schedules applications and services on Linux, Windows, and Mac                                |
| [Vault](https://www.vaultproject.io/)    | A Tool for Managing Secrets                                                                                        |
| [Elastic Stack](https://www.elastic.co/) | Reliably and securely take data from any source, in any format, and search, analyze, and visualize it in real time |

## Prerequisites

The following software is required to build images using Packer and export them as Vagrant [Boxes](https://www.vagrantup.com/docs/boxes.html):

- [Packer](https://www.packer.io/downloads.html)
- [Vagrant](https://www.vagrantup.com/downloads.html)
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

## Usage

### Using Packer

To generate a machine image using Packer, use the [`build`](https://www.packer.io/docs/commands/build.html) command. The packer build command takes a template and runs all the builds within it to generate a set of artifacts.

	$ cd ubuntu
	$ packer build 16.04.3-server-amd64.json

To enable the logger during the `build` process, set the `PACKER_LOG` environment variable to any value other than "" (empty string) or "0".

	$ PACKER_LOG=1 packer build 16.04.3-server-amd64.json

### Creating a Vagrant Box

	$ cd ..
	$ vagrant up

## Networking

### Forwarded Ports

The following services are accessible via a web browser on their respective ports:

| Port   | Protocol | Description     |
|--------|----------|-----------------|
| `4646` | TCP      | Nomad HTTP API  |
| `5601` | TCP      | Kibana UI       |
| `8200` | TCP      | Vault HTTP API  |
| `8500` | TCP      | Consul HTTP API |

**Note:** By default, the Vagrant box does *not* enable port correction; therefore, [port collisions](https://www.vagrantup.com/docs/networking/forwarded_ports.html#port-collisions-and-correction) are not auto-corrected. This behavior is intentional as the services running in the virtual machine are configured to run on their default ports.

### Forwarding Additional Ports

In some scenarios, forwarding additional ports may be required. To forward additional ports, modify the `Vagrantfile` using the syntax defined on their [website](https://www.vagrantup.com/docs/networking/forwarded_ports.html#defining-a-forwarded-port).

Below is an example of the syntax for forwarding a port:

```ruby
Vagrant.configure("2") do |config|
  config.vm.network "forwarded_port", guest: 80, host: 8080
end
```

## License

[pennsignals](https://github.com/pennsignals) @ [MIT](https://github.com/pennsignals/packer-templates/blob/master/LICENSE)
