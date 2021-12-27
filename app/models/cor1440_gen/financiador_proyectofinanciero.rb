module Cor1440Gen
  class FinanciadorProyectofinanciero < ActiveRecord::Base
    belongs_to :financiador, class_name: 'Cor1440Gen::Financiador', 
      foreign_key: 'financiador_id', optional: false
    belongs_to :proyectofinanciero, 
      class_name: 'Cor1440Gen::Proyectofinanciero',
      foreign_key: 'proyectofinanciero_id', optional: false
  end
end

