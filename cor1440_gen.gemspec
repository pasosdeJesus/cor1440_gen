$:.push File.expand_path("../lib", __FILE__)
# encoding: UTF-8 

# Maintain your gem's version:
require "cor1440_gen/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cor1440_gen"
  s.version     = Cor1440Gen::VERSION
  s.authors     = ["Vladimir Támara Patiño"]
  s.email       = ["vtamara@pasosdeJesus.org"]
  s.homepage    = "http://github.com/pasosdeJesu/cor1440_gen"
  s.summary     = "Motor para planeación y seguimiento de actividades e informes en una ONGs"
  s.description = "Partes comunes"
  s.license     = "Dominio Público de acuerdo a Legislación Colombiana"

  s.files = Dir["{app,config,db,lib}/**/*", "LICENCIA.md", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]


  s.add_dependency "jquery-rails"

  s.add_runtime_dependency "rails"
  s.add_runtime_dependency "devise"
  s.add_runtime_dependency "paperclip"

  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "capybara"
  s.add_development_dependency "factory_girl_rails"

end
