# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'depend/version'

Gem::Specification.new do |spec|
  spec.name          = "depend"
  spec.version       = Depend::VERSION
  spec.authors       = ["Newell Zhu"]
  spec.email         = ["zlx.star@gmail.com"]
  spec.license       = 'MIT'
  spec.summary       = %q{RubyGems Native Depend Solution.}
  spec.description   = %q{RubyGems Native Depend Solution.}
  spec.homepage      = "https://github.com/zlx/depend"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "ohai", "~> 0.6.20"

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.7.0"
end
