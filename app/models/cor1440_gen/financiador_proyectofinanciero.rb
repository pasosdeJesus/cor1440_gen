# encoding: UTF-8

module Cor1440Gen
  class FinanciadorProyectofinanciero < ActiveRecord::Base
    belongs_to :financiador, class_name: 'Cor1440Gen::Financiador', 
      foreign_key: 'financiador_id'
    belongs_to :proyectofinanciero, 
      class_name: 'Cor1440Gen::Proyectofinanciero',
      foreign_key: 'proyectofinanciero_id'
  end
end

