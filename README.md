# vagrant info
[![Travis build status](https://travis-ci.org/marsam/vagrant-info.png?branch=master)](https://travis-ci.org/marsam/vagrant-info)

> **Disclaimer** This plugin actually doesn't nothing more than the commands [ssh-config][] and [global-status][]

## Installation

    $ vagrant plugin install vagrant-info

## Usage

This package offers two vagrant subcommands:

`info-ssh`
: Outputs the same output as [ssh-config][] but with the machine `id` as instead machine name in the `Hostname`.

`info-ssh`
: Outputs a csv with the entries of [machine_index](https://github.com/mitchellh/vagrant/blob/master/lib/vagrant/machine_index.rb), same as [global-status][]

### Tutorial
Let's guess that you have the following [multi-machine](https://docs.vagrantup.com/v2/multi-machine/) Vagrantfile, inside the directory `~/some/where`:

```ruby
# -*- mode: ruby -*-

Vagrant.configure("2") do |config|
  config.ssh.forward_agent = true

  config.vm.define "web" do |web|
    web.vm.box      = "ubuntu/trusty64"
    web.vm.hostname = "ubuntu"
  end

  config.vm.define "db" do |db|
    db.vm.box      = "chef/centos-6.5"
    db.vm.hostname = "centos"
  end
end
```

And you need to connect through ssh to the machine named `db`

**Normal steps**

1. Start up the machine `db`, you can choose the following options:
   + Go to `~/some/where` and execute `vagrant up db`
   + Check the `id` of your machine with `vagrant global-status` or `vagrant info-index` and execute `vagrant up <id>`

2. Go to `~/some/where` and execute `vagrant ssh db`

**With `vagrant-info`**

1. (Same step 1.)
2. Execute `vagrant info-ssh <id> >> ~/.ssh/config` and the next time you can use: `ssh <id>`.

   If you don't want to polute your `ssh_config(5)` with configurations of vagrant machines you can use a custom configfile:

   ```
   $ vagrant info-ssh <id> >> ~/.vagrant-sshconfig
   $ ssh -T ~/.vagrant-sshconfig <id>
   ```

[ssh-config]: https://docs.vagrantup.com/v2/cli/ssh_config.html "vagrant ssh-config"
[global-status]: https://docs.vagrantup.com/v2/cli/global-status.html "vagrant global-status"
