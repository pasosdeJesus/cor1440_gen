# frozen_string_literal: true

require "cor1440_gen/concerns/controllers/informes_controller"

module Cor1440Gen
  class InformesController < ApplicationController
    before_action :set_informe, only: [:show, :edit, :update, :destroy]
    load_and_authorize_resource class: Cor1440Gen::Informe

    include Cor1440Gen::Concerns::Controllers::InformesController
  end
end
