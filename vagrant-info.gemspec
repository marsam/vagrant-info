# -*- coding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vagrant-info/version'

Gem::Specification.new do |spec|
  spec.name          = "vagrant-info"
  spec.version       = VagrantPlugins::Info::VERSION
  spec.authors       = ["Mario Rodas"]
  spec.email         = ["marsam@users.noreply.github.com"]
  spec.summary       = %q{Chispas}
  spec.description   = %q{Chispas}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
end
