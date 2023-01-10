# frozen_string_literal: true

require "cor1440_gen/concerns/controllers/actividadtipos_controller"

module Cor1440Gen
  module Admin
    class ActividadtiposController < Msip::Admin::BasicasController
      before_action :set_actividadtipo,
        only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource class: Cor1440Gen::Actividadtipo
      include Cor1440Gen::Concerns::Controllers::ActividadtiposController
    end
  end
end
