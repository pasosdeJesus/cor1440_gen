require_dependency "cor1440_gen/concerns/controllers/personas_controller"

module Sip
  class PersonasController < Heb412Gen::ModelosController

    load_and_authorize_resource class: Sip::Persona
    include Cor1440Gen::Concerns::Controllers::PersonasController
  end
end
