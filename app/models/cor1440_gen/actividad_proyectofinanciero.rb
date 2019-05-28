# encoding: UTF-8

module Cor1440Gen
  class ActividadProyectofinanciero < ActiveRecord::Base
    belongs_to :actividad, class_name: 'Cor1440Gen::Actividad', 
      foreign_key: 'actividad_id'
    belongs_to :proyectofinanciero, 
      class_name: 'Cor1440Gen::Proyectofinanciero',
      foreign_key: 'proyectofinanciero_id'
  end
end

