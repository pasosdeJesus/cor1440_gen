# frozen_string_literal: true

require "msip/concerns/controllers/usuarios_controller"

module Cor1440Gen
  module Concerns
    module Controllers
      module UsuariosController
        extend ActiveSupport::Concern

        included do
          include Msip::Concerns::Controllers::UsuariosController

          def atributos_index
            [
              :id,
              :nusuario,
              :nombre,
              :rol,
              :oficina_id,
              :email,
              :tema,
              :created_at_localizada,
              :habilitado,
            ]
          end

          def atributos_form
            [
              :nusuario,
              :nombre,
              :descripcion,
              :rol,
              :oficina_id,
              :email,
              :tema,
              :idioma,
              :encrypted_password,
              :fechacreacion_localizada,
              :fechadeshabilitacion_localizada,
              :failed_attempts,
              :unlock_token,
              :locked_at,
            ]
          end

          private

          def lista_params_cor1440_gen
            lista_params_msip
          end

          def lista_params
            lista_params_cor1440_gen
          end

          def usuario_params
            p = params.require(:usuario).permit(lista_params)
            p
          end
        end # included
      end
    end
  end
end
