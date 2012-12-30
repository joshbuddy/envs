# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'envs/version'

Gem::Specification.new do |gem|
  gem.name          = "envs"
  gem.version       = Envs::VERSION
  gem.authors       = ["Josh Hull"]
  gem.email         = ["joshbuddy@gmail.com"]
  gem.description   = %q{Sync your .env and .env.default files}
  gem.summary       = %q{Sync your .env and .env.default files.}
  gem.homepage      = "https://github.com/joshbuddy/envs"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "trollop"
  gem.add_dependency "highline"
  gem.add_dependency "rainbow"
  gem.add_development_dependency "minitest"
end
