# frozen_string_literal: true

require "cor1440_gen/concerns/models/actividad_orgsocial"

module Cor1440Gen
  # Relación n:n entre Actividad y Organización Social
  class ActividadOrgsocial < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::ActividadOrgsocial
  end
end
