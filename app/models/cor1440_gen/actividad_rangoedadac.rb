# frozen_string_literal: true

require "cor1440_gen/concerns/models/actividad_rangoedadac"

module Cor1440Gen
  class ActividadRangoedadac < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::ActividadRangoedadac
  end
end
