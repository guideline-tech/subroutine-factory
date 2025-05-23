# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'subroutine/factory/version'

Gem::Specification.new do |spec|
  spec.name          = "subroutine-factory"
  spec.version       = Subroutine::Factory::VERSION
  spec.authors       = ["Mike Nelson"]
  spec.email         = ["mike@mnelson.io"]

  spec.summary       = %q{Test factories for ops using Subroutine Ops}
  spec.description   = %q{Test factories for ops using Subroutine Ops}
  spec.homepage      = "https://github.com/guideline-tech/subroutine-factory"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
    spec.metadata["rubygems_mfa_required"] = "true"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir["lib/**/*"] + Dir["*.gemspec"] + Dir["bin/**/*"]
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "subroutine"
  spec.add_dependency "activesupport", ">= 3.0"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "minitest-reporters"

end
