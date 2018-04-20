[![Build Status](https://img.shields.io/travis/pennsignals/packer-templates.svg?style=flat-square)](https://travis-ci.org/pennsignals/packer-templates)

> A phased approach to continuous delivery is not only preferable, it's infinitely more manageable. - [Maurice Kherlakian](https://twitter.com/mkherlakian)

> The most powerful tool we have as developers is automation. - [Scott Hanselman](https://twitter.com/shanselman)

## Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Usage](#usage)
  - [Using Packer](#using-packer)
  - [Creating a Vagrant Box](#creating-a-vagrant-box)
  - [Custom `Vagrantfile` Configuration](#custom-vagrantfile-configuration)
- [Supported Hypervisors](#supported-hypervisors)
- [Using the local Docker registry](#using-the-local-docker-registry)
- [User Interfaces](#user-interfaces)
- [Networking](#networking)
  - [Forwarded Ports](#forwarded-ports)
  - [Forwarding Additional Ports](#forwarding-additional-ports)
- [License](#license)

## Overview

This repository contains a [Packer Template](https://www.packer.io/docs/templates/index.html) to create a machine image using the Ubuntu 16.04.3 LTS (Xenial Xerus) server disk image. The machine image contains the following software:

| Name                                                 | Description                                                                                                        |
|------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------|
| [Consul](https://www.consul.io/)                     | A distributed, highly available system                                                                             |
| [Nomad](https://www.nomadproject.io/)                | A single binary that schedules applications and services on Linux, Windows, and Mac                                |
| [Vault](https://www.vaultproject.io/)                | A Tool for Managing Secrets                                                                                        |
| [Elastic Stack](https://www.elastic.co/)             | Reliably and securely take data from any source, in any format, and search, analyze, and visualize it in real time |
| [Docker Registry](https://docs.docker.com/registry/) | A stateless, highly scalable server side application that stores and lets you distribute Docker images             |

## Prerequisites

The following software is required to build images using Packer and export them as Vagrant [Boxes](https://www.vagrantup.com/docs/boxes.html):

- [Ansible](http://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- [Packer](https://www.packer.io/downloads.html)
- [Vagrant](https://www.vagrantup.com/downloads.html)
- *At least* one of the [supported hypervisors](#supported-hypervisors)

## Usage

### Using Packer

To generate a machine image using Packer, use the [`build`](https://www.packer.io/docs/commands/build.html) command. The packer build command takes a template and runs all the builds within it to generate a set of artifacts.

By default, the `build` command runs all of the builds defined in the Packer Template. To build only a specific set of builds, use the `-only` flag followed by a comma-separated list of builder names (e.g., `virtualbox-iso`).

	$ cd ubuntu
	$ packer build -only=virtualbox-iso 16.04.3-server-amd64.json

To enable the logger during the `build` process, set the `PACKER_LOG` environment variable to any value other than "" (empty string) or "0".

	$ PACKER_LOG=1 packer build -only=virtualbox-iso 16.04.3-server-amd64.json

If the Packer build is successful, then it creates a [Vagrant Box](https://www.vagrantup.com/docs/boxes.html) in the `boxes` directory.

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

Currently, the [`Vagrantfile`](Vagrantfile) contains two configuration blocks. The first configuration block defines the default configuration for the `server` node and the `client` node and should *not* be modified. The second configuration block is for any custom configurations such as [port forwarding](https://www.vagrantup.com/docs/networking/forwarded_ports.html).

## Supported Hypervisors

This repository supports the following hypervisors:

| Hypervisor                                                                                                                       | Vagrant Command                    |
|----------------------------------------------------------------------------------------------------------------------------------|------------------------------------|
| [VirtualBox](https://www.virtualbox.org/)                                                                                        | `vagrant up --provider=virtualbox` |
| [KVM](https://www.linux-kvm.org/page/Main_Page) via [vagrant-libvirt](https://github.com/vagrant-libvirt/vagrant-libvirt) plugin | `vagrant up --provider=libvirt`    |

## Using the local Docker registry

The Vagrant box contains a local [Docker Registry](https://docs.docker.com/registry/) for storing Docker images. All incoming **host** network traffic on port `5000` is forwarded to port `443` on the client (**guest**) node. See the [port forwarding](https://github.com/pennsignals/packer-templates/blob/master/Vagrantfile#L24) configuration in the `Vagrantfile` for additional details. To push a Docker image from the **host** machine, run the following command(s):

    $ docker pull busybox
    $ docker tag busybox registry.service.consul:5000/my-busybox
    $ docker push registry.service.consul:5000/my-busybox

Docker provides additional [documentation](https://docs.docker.com/registry/deploying/#copy-an-image-from-docker-hub-to-your-registry) for pushing images to a local registry.

To pull the recently pushed image on the `client` node, run the following command(s):

    $ vagrant ssh client
    $ docker pull registry.service.consul/my-busybox

**Note:** The `client` node does **not** require the port since the registry is secured using TLS.

## User Interfaces

The `sever` node runs both the Consul and Nomad web user interfaces. To access them, visit the following links in a web browser:

| Consul                                                                                                                                       | Nomad                                                                                                                                        |
|----------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------|
| ![screen shot 2018-01-26 at 1 59 28 pm](https://user-images.githubusercontent.com/2184329/39053344-c69910c6-447c-11e8-88e6-66d23616037e.png) | ![screen shot 2018-01-26 at 1 59 36 pm](https://user-images.githubusercontent.com/2184329/39053346-c6b06e60-447c-11e8-8595-b7bd3c5cfdc3.png) |
| [http://localhost:8500/](http://localhost:8500/)                                                                                             | [http://localhost:4646/](http://localhost:4646/)                                                                                             |

| Vault                                                                                                                                        | Kibana                                                                                                                                       |
|----------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------|
| ![screen shot 2018-04-18 at 3 08 25 pm](https://user-images.githubusercontent.com/2184329/39053345-c6a55a52-447c-11e8-83f0-b3978817b673.png) | ![screen shot 2018-01-29 at 2 05 11 pm](https://user-images.githubusercontent.com/2184329/39053347-c6bb079e-447c-11e8-8bc4-8f4db278ae13.png) |
| [http://localhost:8200/](http://localhost:8200/)                                                                                             | [http://localhost:5601](http://localhost:5601)                                                                                               |

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
  config.vm.define "server" do |server|
    server.vm.network "forwarded_port", guest: 1337, host: 1337
  end
end
```

## License

[MIT](https://github.com/pennsignals/packer-templates/blob/master/LICENSE) @ [pennsignals](https://github.com/pennsignals)
