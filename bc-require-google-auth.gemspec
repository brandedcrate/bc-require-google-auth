# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bc/require_google_auth/version'

Gem::Specification.new do |spec|
  spec.name          = "bc-require-google-auth"
  spec.version       = Bc::RequireGoogleAuth::VERSION
  spec.authors       = ["Stephen Crosby"]
  spec.email         = ["stephen@brandedcrate.com"]
  spec.summary       = %q{Rack middleware to require google auth}
  spec.description   = %q{Forces users to login through google OAuth2 using Rack::Session and OmniAuth}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
end
