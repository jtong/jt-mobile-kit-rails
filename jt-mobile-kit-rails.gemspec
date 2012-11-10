# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jt-mobile-kit-rails/version'

Gem::Specification.new do |gem|
  gem.name          = "jt-mobile-kit-rails"
  gem.version       = Jt::Mobile::Kit::Rails::VERSION
  gem.authors       = ["jtong"]
  gem.email         = ["tj19832@gmail.com"]
  gem.description   = %q{generate jt-mobile-kit in rails app}
  gem.summary       = %q{generate jt-mobile-kit in rails app}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
