# frozen_string_literal: true

require "cor1440_gen/concerns/controllers/actividadespf_proyectofinanciero_controller"

module Cor1440Gen
  class ActividadespfProyectofinancieroController < ApplicationController
    before_action :preparar_actividadpf_proyectofinanciero
    load_and_authorize_resource class: Cor1440Gen::Actividadpf

    include Cor1440Gen::Concerns::Controllers::ActividadespfProyectofinancieroController
  end
end
