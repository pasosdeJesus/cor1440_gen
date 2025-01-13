# frozen_string_literal: true

require "cor1440_gen/concerns/controllers/anexos_proyectofinanciero_controller"

module Cor1440Gen
  class AnexosProyectofinancieroController < ApplicationController
    load_and_authorize_resource class: Msip::Anexo
    before_action :prepara_anexo_proyectofinanciero

    include Cor1440Gen::Concerns::Controllers::AnexosProyectofinancieroController
  end
end
