# encoding: UTF-8

module Cor1440Gen
  class ProyectoProyectofinanciero < ActiveRecord::Base
    belongs_to :proyecto, class_name: 'Cor1440Gen::Proyecto', 
      foreign_key: 'proyecto_id'
    belongs_to :proyectofinanciero, 
      class_name: 'Cor1440Gen::Proyectofinanciero', 
      foreign_key: 'proyectofinanciero_id'
  end
end

