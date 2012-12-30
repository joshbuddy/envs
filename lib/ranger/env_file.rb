module Ranger
  class EnvFile < Hash
    attr_reader :path

    def initialize(path)
      @path = path
      parse if exist?
    end

    def parse
      new_hash = {}
      File.open(@path).each_line do |line|
        case line
        when /^\s*$/, /^#/ # ignore
        else
          line.chomp
          key, value = line.split('=', 2)
          new_hash[key] = value.strip
        end
      end
      update(new_hash)
    end

    def []=(key, value)
      super(key, value)
      File.open(@path, "a") do |f|
        f << "#{key}=#{value}\n"
      end
    end

    private
    def exist?
      File.exist?(@path)
    end
  end
end
