require 'rubygems'
require 'rake'
require 'echoe'
Echoe.new('ethiopic_calendar','0.1.5') do |p|
  p.description      = "A simple Ethiopic to Gregorian calendar changer"
  p.url              = "http://github.com/vedtechpro/ethiopic_calendar"
  p.author          = ["Gebreyohannes Zenebe", "Yared Getachew Tessema"]
  p.email           = ["gebreyohannes@gemhalo.org","yared@gemhalo.org"]
  p.ignore_pattern   = ["tmp/*","script/*"]
  p.development_dependencies = []
end
Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
