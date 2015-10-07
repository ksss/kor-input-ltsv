# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kor/input/ltsv/version'

Gem::Specification.new do |spec|
  spec.name          = "kor-input-ltsv"
  spec.version       = Kor::Input::Ltsv::VERSION
  spec.authors       = ["ksss"]
  spec.email         = ["co000ri@gmail.com"]

  spec.summary       = %q{LTSV input plugin for kor.}
  spec.description   = %q{LTSV input plugin for kor.}
  spec.homepage      = "https://github.com/ksss/kor-input-ltsv"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "kor"
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rgot"
end