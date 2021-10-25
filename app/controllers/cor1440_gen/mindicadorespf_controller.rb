require_dependency 'cor1440_gen/concerns/controllers/mindicadorespf_controller'

module Cor1440Gen
  class MindicadorespfController < Sip::ModelosController

    before_action :set_mindicadorpf, 
      only: [:show, :edit, :update, :destroy]
    load_and_authorize_resource class: Cor1440Gen::Mindicadorpf

    include Cor1440Gen::Concerns::Controllers::MindicadorespfController

  end
end
