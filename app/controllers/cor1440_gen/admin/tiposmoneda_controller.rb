require_dependency "cor1440_gen/concerns/controllers/tiposmoneda_controller"

module Cor1440Gen
  module Admin
    class TiposmonedaController < Sip::Admin::BasicasController
      include Cor1440Gen::Concerns::Controllers::TiposmonedaController
        before_action :set_tipomoneda, 
          only: [:show, :edit, :update, :destroy]
        load_and_authorize_resource  class: Cor1440Gen::Tipomoneda
    end
  end
end
