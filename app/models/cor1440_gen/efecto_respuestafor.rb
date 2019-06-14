# encoding: UTF-8

require 'cor1440_gen/concerns/models/efecto_respuestafor'

module Cor1440Gen
  class EfectoRespuestafor < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::EfectoRespuestafor
  end
end
