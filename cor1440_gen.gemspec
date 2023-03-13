# encoding: utf-8
# frozen_string_literal: true

$:.push(File.expand_path("../lib", __FILE__))

# Maintain your gem's version:
require "cor1440_gen/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cor1440_gen"
  s.version     = Cor1440Gen::VERSION
  s.authors     = ["Vladimir Támara Patiño"]
  s.email       = ["vtamara@pasosdeJesus.org"]
  s.homepage    = "http://gitlab.com/pasosdeJesu/cor1440_gen"
  s.summary     = "Motor para planeación y seguimiento de actividades e informes en una ONGs"
  s.description = "Partes comunes"
  s.license     = "Dominio Público de acuerdo a Legislación Colombiana"

  s.files = Dir["{app,config,db,lib}/**/*", "LICENCIA.md", "Rakefile", "README.md"]

  s.add_runtime_dependency("devise")
  s.add_runtime_dependency("heb412_gen")
  s.add_runtime_dependency("kt-paperclip")
  s.add_runtime_dependency("mr519_gen")
  s.add_runtime_dependency("msip")
  s.add_runtime_dependency("rails")
end
