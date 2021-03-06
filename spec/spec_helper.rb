$: << File.expand_path("../../lib", __FILE__)

require 'envs'
require 'minitest/autorun'

class MiniTest::Spec

  def clear_project
    FileUtils.rm_rf("/tmp/envs-test")
    FileUtils.mkdir_p("/tmp/envs-test")
  end

  def run_envs(*args)
    args.concat %w(-r /tmp/envs-test)
    ARGV.replace(args)
    pid = fork { Envs::CLI.run }
    _, status = Process.waitpid2(pid)
    status
  end

  def assert_synced(vals = {})
    assert_equal vals, env_result
    assert_equal vals, default_result
  end

  def parse_env_file(f)
    return nil unless File.exist?(f)
    env = {}
    File.read(f).split(/\n/).each do |line|
      line.strip!
      unless line.empty?
        key, value = line.split("=", 2)
        env[key] = value
      end
    end
    env
  end

  def env_result
    parse_env_file("/tmp/envs-test/.env")
  end

  def default_result
    parse_env_file("/tmp/envs-test/.env.default")
  end

  def env(vals)
    add_vals("/tmp/envs-test/.env", vals)
  end

  def default(vals)
    add_vals("/tmp/envs-test/.env.default", vals)
  end

  private
  def add_vals(file, vals)
    File.open(file, "a") do |f|
      vals.each do |k, v|
        f << "#{k}=#{v}\n"
      end
    end
  end
end
