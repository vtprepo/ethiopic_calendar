# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ethiopic_calendar/version'

Gem::Specification.new do |gem|
  gem.name          = "ethiopic_calendar"
  gem.version       = EthiopicCalendar::VERSION
  gem.authors       = ["G/yohannes Zenebe","Yared Getachew"]
  gem.email         = ["gebreyohannes@gemhalo.org","yared@gemhalo.org"]
  gem.description   = %q{Simple calendar date conversion between Ethiopian and Gregorian}
  gem.summary       = %q{date conversion from Gregorian to Ethiopic and vice versa}
  gem.homepage      = "https://github.com/vedtechpro/ethiopic_calendar"

  gem.files         = `git ls-files`.split("\n")
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
