# frozen_string_literal: true

require "cor1440_gen/concerns/models/asistencia"

module Cor1440Gen
  class Asistencia < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Asistencia
  end
end
