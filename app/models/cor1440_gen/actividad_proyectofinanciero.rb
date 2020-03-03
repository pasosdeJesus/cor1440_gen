require 'cor1440_gen/concerns/models/actividad_proyectofinanciero'

module Cor1440Gen
  class ActividadProyectofinanciero < ActiveRecord::Base
        include Cor1440Gen::Concerns::Models::ActividadProyectofinanciero
  end
end
