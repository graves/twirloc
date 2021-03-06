# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'twirloc/version'

Gem::Specification.new do |spec|
  spec.name          = "twirloc"
  spec.version       = Twirloc::VERSION
  spec.authors       = ["Thomas Graves"]
  spec.email         = ["thomas@ooo.pm"]

  spec.summary       = %q{Does a thing}
  spec.description   = %q{Does a thing well}
  spec.homepage      = "https://github.com/graves/twirloc2"
  spec.license       = "MIT"

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

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "pry"

  spec.add_runtime_dependency "twitter"
  spec.add_runtime_dependency "thor"
  spec.add_runtime_dependency "dotenv"
  spec.add_runtime_dependency "faraday"
end
