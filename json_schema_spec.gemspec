# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'json_schema_spec/version'

Gem::Specification.new do |spec|
  spec.name          = "json_schema_spec"
  spec.version       = JsonSchemaSpec::VERSION
  spec.authors       = ["timakin"]
  spec.email         = ["timaki.st@gmail.com"]

  spec.summary       = %q{Ruby-based Spec for JSON Schema}
  spec.description   = %q{Test JSON Schema itself with JSON Schema and a little ruby code.}
  spec.homepage      = "https://github.com/timakin/json_schema_spec"

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

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
