require 'csv'
require 'optparse'

require "vagrant/util/safe_puts"

module VagrantPlugins
  module CommandInfo
    class Command < Vagrant.plugin("2", :command)
      include Vagrant::Util::SafePuts

      def self.synopsis
        "Ouput the ssh configuration of a vagrant box."
      end

      def execute
        opts = OptionParser.new do |o|
          o.banner = "Usage: vagrant sshinfo [name]"
          o.separator ""
        end
        argv = parse_options(opts)
        return if !argv

        with_target_vms(argv) do |machine|
          safe_puts sshconfig machine
          safe_puts
        end
        0
      end

      protected

      def sshconfig(machine)
        ssh_info = machine.ssh_info
        raise Vagrant::Errors::SSHNotReady if ssh_info.nil?
        variables = {
          host_key: machine.index_uuid.to_s[0...7],
          ssh_host: ssh_info[:host],
          ssh_port: ssh_info[:port],
          ssh_user: ssh_info[:username],
          private_key_path: ssh_info[:private_key_path],
          forward_agent: ssh_info[:forward_agent],
          forward_x11:   ssh_info[:forward_x11],
          proxy_command: ssh_info[:proxy_command]
        }
        template = "commands/ssh_config/config"
        Vagrant::Util::TemplateRenderer.render(template, variables)
      end

    end
  end
end
