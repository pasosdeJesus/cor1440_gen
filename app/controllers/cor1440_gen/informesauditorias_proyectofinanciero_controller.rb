# frozen_string_literal: true

require "cor1440_gen/concerns/controllers/Informesauditorias_proyectofinanciero_controller"

module Cor1440Gen
  class InformesauditoriasProyectofinancieroController < ApplicationController
    load_and_authorize_resource class: Informeauditoria
    before_action :prepara_informeauditoria_proyectofinanciero

    include Cor1440Gen::Concerns::Controllers::InformesauditoriasProyectofinancieroController
  end
end
