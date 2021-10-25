require 'cor1440_gen/concerns/models/proyectofinanciero_usuario'

module Cor1440Gen
  class ProyectofinancieroUsuario < ActiveRecord::Base
        include Cor1440Gen::Concerns::Models::ProyectofinancieroUsuario
  end
end
