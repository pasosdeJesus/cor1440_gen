module Cor1440Gen
  class ProyectoProyectofinanciero < ActiveRecord::Base
    belongs_to :proyecto, class_name: 'Cor1440Gen::Proyecto', 
      foreign_key: 'proyecto_id', optional: false
    belongs_to :proyectofinanciero, 
      class_name: 'Cor1440Gen::Proyectofinanciero', 
      foreign_key: 'proyectofinanciero_id', optional: false
  end
end

