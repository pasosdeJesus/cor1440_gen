# frozen_string_literal: true

require "cor1440_gen/concerns/controllers/desembolsos_proyectofinanciero_controller"

module Cor1440Gen
  class DesembolsosProyectofinancieroController < ApplicationController
    load_and_authorize_resource class: Desembolso
    before_action :prepara_desembolso_proyectofinanciero

    include Cor1440Gen::Concerns::Controllers::DesembolsosProyectofinancieroController
  end
end
