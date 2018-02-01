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

By default, the `build` command runs all the builds within it. To build only a specific set of builds, use the `-only` flag followed by a comma-separated list of builder names (e.g., `virtualbox-iso`).

	$ cd ubuntu
	$ packer build -only=virtualbox-iso 16.04.3-server-amd64.json

To enable the logger during the `build` process, set the `PACKER_LOG` environment variable to any value other than "" (empty string) or "0".

	$ PACKER_LOG=1 packer build -only=virtualbox-iso 16.04.3-server-amd64.json

If the Packer build is successful, then it creates a [Vagrant Box](https://www.vagrantup.com/docs/boxes.html) in the [`builds`](builds) directory.

### Creating a Vagrant Box

The [`Vagrantfile`](Vagrantfile) contains [multiple guest machine definitions](https://www.vagrantup.com/docs/multi-machine/): `server` and `client`, respectively. Both the `server` node and the `client` node contain the `consul`, `nomad`, and `vault` binaries; the main difference is their agent configurations. The agents in the `server` node run in server mode, whereas the agents in the `client` node run in client mode.

	$ cd packer-templates
	$ vagrant up

If the `vagrant up` command is successful, then both the `server` node and `client` node are accessible via SSH.

To SSH into the `server` node, run the following command:

	$ vagrant ssh server

To SSH into the `client` node, run the following command:

	$ vagrant ssh client

### Custom `Vagrantfile` Configuration

Currently, the [`Vagrantfile`](Vagrantfile) contains two configuration blocks. The first configuration block defines the default configuration for the `server` node and the `client` node. The second configuration block is for any custom configurations such as [port forwarding](https://www.vagrantup.com/docs/networking/forwarded_ports.html).

## User Interfaces

The `sever` node runs both the Consul and Nomad web user interfaces. To access them, visit the following links in a web browser:

| Consul                                                                                                                                       | Nomad                                                                                                                                        | Kibana                                                                                                                                       |
|----------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------|
| ![screen shot 2018-01-26 at 1 59 28 pm](https://user-images.githubusercontent.com/2184329/35455767-2ae43ea2-02a1-11e8-966e-d335f8c6df10.png) | ![screen shot 2018-01-26 at 1 59 36 pm](https://user-images.githubusercontent.com/2184329/35455779-345fda18-02a1-11e8-84b8-9c73975dd534.png) | ![screen shot 2018-01-29 at 2 05 11 pm](https://user-images.githubusercontent.com/2184329/35528955-7d24c250-04fd-11e8-9a36-426c257a2321.png) |
| [http://localhost:8500/](http://localhost:8500/)                                                                                             | [http://localhost:4646/](http://localhost:4646/)                                                                                             | [http://localhost:5601](http://localhost:5601)                                                                                               |

## Networking

### Forwarded Ports

The following services are accessible via a web browser on their respective ports:

| Port   | Protocol | Description                                                                |
|--------|----------|----------------------------------------------------------------------------|
| `4646` | TCP      | [Nomad HTTP API](https://www.nomadproject.io/api/index.html)               |
| `5601` | TCP      | [Kibana UI](https://www.elastic.co/guide/en/kibana/current/dashboard.html) |
| `8200` | TCP      | [Vault HTTP API](https://www.vaultproject.io/api/index.html)               |
| `8500` | TCP      | [Consul HTTP API](https://www.consul.io/api/index.html)                    |

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
