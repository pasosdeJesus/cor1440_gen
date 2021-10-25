require_dependency "cor1440_gen/concerns/controllers/campostind_controller"

module Cor1440Gen
  class CampostindController < Sip::ModelosController

    load_and_authorize_resource class: Cor1440Gen::Proyectofinanciero
    include Cor1440Gen::Concerns::Controllers::CampostindController
  end
end
