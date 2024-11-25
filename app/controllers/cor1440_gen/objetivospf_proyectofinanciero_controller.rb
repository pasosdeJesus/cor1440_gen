# frozen_string_literal: true

require "cor1440_gen/concerns/controllers/objetivospf_proyectofinanciero_controller"

module Cor1440Gen
  class ObjetivospfProyectofinancieroController < ApplicationController
    before_action :preparar_objetivopf_proyectofinanciero
    load_and_authorize_resource class: Cor1440Gen::Objetivopf

    include Cor1440Gen::Concerns::Controllers::ObjetivospfProyectofinancieroController
  end
end
