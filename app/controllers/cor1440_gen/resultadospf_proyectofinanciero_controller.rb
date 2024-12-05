# frozen_string_literal: true

require "cor1440_gen/concerns/controllers/resultadospf_proyectofinanciero_controller"

module Cor1440Gen
  class ResultadospfProyectofinancieroController < ApplicationController
    before_action :preparar_resultadopf_proyectofinanciero
    load_and_authorize_resource class: Cor1440Gen::Resultadopf

    include Cor1440Gen::Concerns::Controllers::ResultadospfProyectofinancieroController
  end
end
