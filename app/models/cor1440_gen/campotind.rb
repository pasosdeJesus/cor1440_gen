# frozen_string_literal: true

require "cor1440_gen/concerns/models/campotind"

module Cor1440Gen
  # Campo de un tipo de indicador (obsoleto)
  class Campotind < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Campotind
  end
end
