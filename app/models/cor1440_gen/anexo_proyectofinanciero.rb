# encoding: UTF-8

require 'cor1440_gen/concerns/models/anexo_proyectofinanciero'

module Cor1440Gen
  class AnexoProyectofinanciero < ActiveRecord::Base
        include Cor1440Gen::Concerns::Models::AnexoProyectofinanciero 
  end
end
