module VagrantPlugins
  module CommandInfo
    class Plugin < Vagrant.plugin("2")
      name "info command"

      description <<-DESC
      This plugin shows the information of a vagrant box
      DESC

      command("info-index") do
        require File.expand_path("../infoindex_command", __FILE__)
        Command
      end

      command("info-ssh") do
        require File.expand_path("../infossh_command", __FILE__)
        Command
      end
    end
  end
end
