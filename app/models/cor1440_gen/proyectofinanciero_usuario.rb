# frozen_string_literal: true

require "cor1440_gen/concerns/models/proyectofinanciero_usuario"

module Cor1440Gen
  # Relación n:n entre convenio financiado y usuario.
  # Un registro corresponde a un usuario con un rol en un convenio financiado.
  class ProyectofinancieroUsuario < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::ProyectofinancieroUsuario
  end
end
