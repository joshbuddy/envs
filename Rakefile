#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.ruby_opts = ["-r./spec/spec_helper"]
  t.pattern = "spec/*_spec.rb"
end
