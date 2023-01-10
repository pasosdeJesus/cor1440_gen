# frozen_string_literal: true

require "cor1440_gen/concerns/models/actividadareas_actividad"

module Cor1440Gen
  class ActividadareasActividad < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::ActividadareasActividad
  end
end
