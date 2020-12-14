require_dependency "cor1440_gen/concerns/controllers/pmsindicadorpf_controller"

module Cor1440Gen
  class PmsindicadorpfController < Heb412Gen::ModelosController
    include Cor1440Gen::Concerns::Controllers::PmsindicadorpfController

    #before_action :set_pmsindicadorpf,
    #  only: [:show, :edit, :update, :destroy]      

    #load_and_authorize_resource  class: Cor1440Gen::Pmsindicadorpf,
    #  only: [:new, :create, :destroy, :edit, :update, :index, :show, :objetivospf]

  end
end
