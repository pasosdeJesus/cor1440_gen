# encoding: UTF-8

require 'cor1440_gen/concerns/models/actividadtipo_actividad'

module Cor1440Gen
  class ActividadtipoActividad < ActiveRecord::Base
        include Cor1440Gen::Concerns::Models::ActividadtipoActividad
  end
end
