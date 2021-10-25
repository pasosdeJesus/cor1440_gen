require 'cor1440_gen/concerns/models/actividadtipo_formulario'

module Cor1440Gen
  class ActividadtipoFormulario < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::ActividadtipoFormulario
  end
end
