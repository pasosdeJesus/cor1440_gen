# encoding: UTF-8

require 'cor1440_gen/concerns/controllers/usuarios_controller'

module Cor1440Gen
  class UsuariosController < Sip::ModelosController

    include Cor1440Gen::Concerns::Controllers::UsuariosController

  end
end
