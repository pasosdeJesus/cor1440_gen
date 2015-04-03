$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "sivel2_sjr/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "sivel2_sjr"
  s.version     = Sivel2Sjr::VERSION
  s.authors     = ["Vladimir Támara Patiño"]
  s.email       = ["vtamara@pasosdeJesus.org"]
  s.homepage    = "http://sivel.sf.net"
  s.summary     = "Motor para el SIVeL 2 del SJR Latinoamérica"
  s.description = "Partes comunes a los sistemas de cada país"
  s.license     = "Dominio Público de acuerdo a Legislación Colombiana"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails"
  s.add_dependency "sivel2_gen"
end
