# frozen_string_literal: true

require "cor1440_gen/concerns/controllers/informesfinancieros_proyectofinanciero_controller"

module Cor1440Gen
  class InformesfinancierosProyectofinancieroController < ApplicationController
    load_and_authorize_resource class: Informefinanciero
    before_action :prepara_informefinanciero_proyectofinanciero

    include Cor1440Gen::Concerns::Controllers::InformesfinancierosProyectofinancieroController
  end
end
