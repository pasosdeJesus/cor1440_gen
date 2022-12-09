require 'cor1440_gen/concerns/models/actividad_anexo'

module Cor1440Gen
  class ActividadAnexo < ActiveRecord::Base
        include Cor1440Gen::Concerns::Models::ActividadAnexo
  end
end
