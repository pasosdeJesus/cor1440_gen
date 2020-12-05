# encoding: UTF-8

require 'cor1440_gen/concerns/controllers/sectoresactores_controller'

module Cor1440Gen
  module Admin
    class SectoresactoresController < Sip::Admin::BasicasController

      before_action :set_sectoractor, 
        only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource  class: Cor1440Gen::Sectoractor

      include Cor1440Gen::Concerns::Controllers::SectoresactoresController
    end
  end
end
