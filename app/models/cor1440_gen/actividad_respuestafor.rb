# encoding: UTF-8

require 'cor1440_gen/concerns/models/actividad_respuestafor'

module Cor1440Gen
  class ActividadRespuestafor < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::ActividadRespuestafor
  end
end
