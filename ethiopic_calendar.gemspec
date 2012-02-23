# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "ethiopic_calendar"
  s.version = "0.1.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Gebreyohannes Zenebe, Yared Getachew Tessema"]
  s.date = "2012-02-23"
  s.description = "A simple Ethiopic to Gregorian calendar changer"
  s.email = ["gebreyohannes@gemhalo.org", "yared@gemhalo.org"]
  s.extra_rdoc_files = ["README.rdoc", "lib/ethiopic_calendar.rb"]
  s.files = ["README.rdoc", "Rakefile", "ethiopic_calendar.gemspec", "lib/ethiopic_calendar.rb", "Manifest"]
  s.homepage = "http://github.com/vedtechpro/ethiopic_calendar"
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Ethiopic_calendar", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "ethiopic_calendar"
  s.rubygems_version = "1.8.10"
  s.summary = "A simple Ethiopic to Gregorian calendar changer"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
