module Cor1440Gen
  class ActividadUsuario < ActiveRecord::Base
    belongs_to :actividad, class_name: 'Cor1440Gen::Actividad', 
      foreign_key: 'actividad_id', optional: false
    belongs_to :usuario, class_name: 'Usuario',
      foreign_key: 'usuario_id', optional: false
  end
end

