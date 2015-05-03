# encoding: UTF-8

module Cor1440Gen
  class ActividadProyecto < ActiveRecord::Base
    belongs_to :actividad, class_name: 'Cor1440Gen::Actividad', 
      foreign_key: 'actividad_id'
    belongs_to :proyecto, class_name: 'Cor1440Gen::Proyecto',
      foreign_key: 'proyecto_id'
  end
end

