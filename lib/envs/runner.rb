require 'rainbow'

module Envs
  class Runner
    def initialize(opts)
      @root = opts[:root]
      Sickill::Rainbow.enabled = !opts[:no_color]
      @count = 0
      @synced_dirs = []
    end

    def run
      puts "Envs! #{VERSION}"

      gitignore = File.join(@root, ".gitignore")
      if File.exist?(gitignore)
        warn "You should probably add .env to your gitignore file fool!".foreground(:red) unless File.read(gitignore).split(/\n/).include?('.env')
      end

      Dir[File.join(@root, "**/.env")].each do |dir|
        sync File.dirname(dir)
      end
      Dir[File.join(@root, "**/.env.default")].each do |dir|
        sync File.dirname(dir)
      end

      puts "Synced #{@count.to_s.foreground(:green)} values in #{@synced_dirs.size.to_s.foreground(:green)} dirs. Your welcome."
    end

    private
    def sync(dir)
      return if @synced_dirs.include?(dir)

      env = EnvFile.new(File.join(dir, ".env"))
      defaults = EnvFile.new(File.join(dir, ".env.default"))
      files = [env, defaults]

      values = defaults.merge(env)
      2.times do
        keys = files.first.keys - files.last.keys
        keys.each do |key|
          value = values[key]
          puts "Adding #{key.foreground(:green)}=#{value.foreground(:green)} to #{files.last.path.foreground(:yellow)}"
          files.last[key] = value
          @count += 1
        end
        files.reverse!
      end
      @synced_dirs << dir
    end
  end
end