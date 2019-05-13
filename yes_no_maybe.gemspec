# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yes_no_maybe/version'

Gem::Specification.new do |spec|
  spec.name          = "yes_no_maybe"
  spec.version       = YesNoMaybe::VERSION
  spec.authors       = ["Warren W. Kretzschmar"]
  spec.email         = ["wkretzsch@gmail.com"]

  spec.summary       = %q{Yes/No/Maybe: When a boolean just isn't enough.}
  spec.homepage      = "https://github.com/zestyzesty/yes_no_maybe.git"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com' to prevent pushes to rubygems.org, or delete to allow pushes to any server."
  end

  spec.add_dependency "activesupport"
  
  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'mongoid', '~> 5.0', '>= 5.0.0'
  spec.add_development_dependency 'sequel', '~> 4.30'
  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'database_cleaner', '~> 1.5', '>= 1.5.1'
  spec.add_development_dependency 'sqlite3', '~> 1.3', '>= 1.3.11'
end
