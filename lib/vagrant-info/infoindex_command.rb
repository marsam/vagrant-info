require 'csv'
require 'optparse'

require "vagrant/util/safe_puts"

module VagrantPlugins
  module CommandInfo
    class Command < Vagrant.plugin("2", :command)
      include Vagrant::Util::SafePuts

      def self.synopsis
        "Outputs machine readable infomation of a vagrant machine_index."
      end

      def execute
        opts = OptionParser.new do |o|
          o.banner = "Usage: vagrant info"
          o.separator ""
        end
        argv = parse_options(opts)
        return if !argv

        columns = [["id", :id],
                   ["name", :name],
                   ["provider", :provider],
                   ["state", :state],
                   ["directory", :vagrantfile_path]]
        output = CSV.generate do |csv|
          csv << columns.map { |header, _| header }
          @env.machine_index.each do |entry|
            csv << columns.map do |_, method|
              v = entry.send(method)
              method == :id ? v[0...7] : v
            end
          end
        end
        safe_puts output
        0
      end

    end
  end
end
