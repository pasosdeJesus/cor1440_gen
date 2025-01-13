# frozen_string_literal: true

require "cor1440_gen/concerns/controllers/Informesnarrativos_proyectofinanciero_controller"

module Cor1440Gen
  class InformesnarrativosProyectofinancieroController < ApplicationController
    load_and_authorize_resource class: Informenarrativo
    before_action :prepara_informenarrativo_proyectofinanciero

    include Cor1440Gen::Concerns::Controllers::InformesnarrativosProyectofinancieroController
  end
end
