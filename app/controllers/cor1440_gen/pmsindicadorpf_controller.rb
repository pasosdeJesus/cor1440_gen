require_dependency "cor1440_gen/concerns/controllers/pmsindicadorpf_controller"

module Cor1440Gen
  class PmsindicadorpfController < Heb412Gen::ModelosController

    load_and_authorize_resource class: Cor1440Gen::Pmindicador
    include Cor1440Gen::Concerns::Controllers::PmsindicadorpfController

  end
end
