# frozen_string_literal: true

require "cor1440_gen/concerns/models/actividadareas_actividad"

module Cor1440Gen
  # Relación n:n entre Área de actividad y Actividad
  class ActividadareasActividad < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::ActividadareasActividad
  end
end
