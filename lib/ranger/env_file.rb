module Ranger
  class EnvFile < Hash
    attr_reader :path

    def initialize(path)
      @path = path
      parse if exist?
    end

    def parse
      File.open(@path).each_line do |line|
        case line
        when /^\s*$/, /^#/ # ignore
        else
          line.chomp
          key, value = line.split('=', 2)
          self[key] = value.strip
        end
      end
    end

    def exist?
      File.exist?(@path)
    end

    def persist
      File.open(@path, 'w') do |f|
        each do |key, val|
          f.puts "#{key}=#{val}"
        end
      end
    end
  end
end
