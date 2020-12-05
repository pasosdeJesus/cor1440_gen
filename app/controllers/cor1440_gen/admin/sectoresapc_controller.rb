require 'cor1440_gen/concerns/controllers/sectoresapc_controller'

module Cor1440Gen
  module Admin
    class SectoresapcController < Sip::Admin::BasicasController

      before_action :set_sectorapc, 
        only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource  class: Cor1440Gen::Sectorapc

      include Cor1440Gen::Concerns::Controllers::SectoresapcController

    end
  end
end
