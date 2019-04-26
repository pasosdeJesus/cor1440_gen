# encoding: UTF-8

require 'cor1440_gen/concerns/models/formulario'
module Mr519Gen
  class Formulario < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Formulario
  end
end
