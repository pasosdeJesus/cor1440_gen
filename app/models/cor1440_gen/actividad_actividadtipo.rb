# encoding: UTF-8

require 'cor1440_gen/concerns/models/actividad_actividadtipo'

module Cor1440Gen
  class ActividadActividadtipo < ActiveRecord::Base
        include Cor1440Gen::Concerns::Models::ActividadActividadtipo
  end
end
