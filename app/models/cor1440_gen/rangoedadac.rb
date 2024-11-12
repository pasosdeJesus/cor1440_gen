# frozen_string_literal: true

require "cor1440_gen/concerns/models/rangoedadac"

module Cor1440Gen
  # Tabla básica Rangos de edad en actividades.
  class Rangoedadac < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Rangoedadac
  end
end
