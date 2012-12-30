require 'trollop'

module Ranger
  class CLI
    def self.run
      new.run
    end

    def run
      global_opts = Trollop::options do
        banner "Manage environment variables on a per-project basis"
        opt :no_color, "Don't be colorized", :short => "-c"
        opt :root, "Project root directory", :short => "-r", :default => Dir.pwd
      end
      runner = Ranger::Runner.new(global_opts)
      runner.run
    end
  end
end