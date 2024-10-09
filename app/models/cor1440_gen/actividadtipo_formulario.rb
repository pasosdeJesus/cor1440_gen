# frozen_string_literal: true

require "cor1440_gen/concerns/models/actividadtipo_formulario"

module Cor1440Gen
  # Relación n:n entre Actividad y Formulario. Para incrustar el
  # formulario en la actividad y permitir sistematizar la información
  # adicional del formulario.
  class ActividadtipoFormulario < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::ActividadtipoFormulario
  end
end
