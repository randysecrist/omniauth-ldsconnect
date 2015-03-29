# -*- encoding: utf-8 -*-
require File.expand_path('../lib/omniauth-ldsconnect/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Randy Secrist"]
  gem.email         = ["randy.secrist@gmail.com"]
  gem.description   = %q{OmniAuth plugin for LDS Connect}
  gem.summary       = %q{OmniAuth plugin for LDS Connect}
  gem.homepage      = "https://ldsconnect.org"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "omniauth-ldsconnect"
  gem.require_paths = ["lib"]
  gem.version       = Omniauth::Ldsconnect::VERSION

  gem.add_runtime_dependency 'omniauth-oauth2', '~> 1.2.0'
end
