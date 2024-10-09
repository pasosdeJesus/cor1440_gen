# frozen_string_literal: true

require "cor1440_gen/concerns/models/actividad"

module Cor1440Gen
  # Una actividad realizada en una fecha especifica
  class Actividad < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Actividad
  end
end
