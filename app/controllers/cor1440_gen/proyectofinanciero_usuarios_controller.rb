# frozen_string_literal: true

require "cor1440_gen/concerns/controllers/proyectofinanciero_usuarios_controller"

module Cor1440Gen
  class ProyectofinancieroUsuariosController < ApplicationController
    load_and_authorize_resource class: ProyectofinancieroUsuario
    before_action :prepara_proyectofinanciero_usuario

    include Cor1440Gen::Concerns::Controllers::ProyectofinancieroUsuariosController
  end
end
