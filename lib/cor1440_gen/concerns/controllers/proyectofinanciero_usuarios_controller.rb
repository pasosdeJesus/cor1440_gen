module Cor1440Gen
  module Concerns
    module Controllers
      module ProyectofinancieroUsuariosController
        extend ActiveSupport::Concern

        included do
          def destroy
          end

          def create
          end

          private

          def prepara_proyectofinanciero_usuario
            @proyectofinanciero = Cor1440Gen::Proyectofinanciero.new(
              proyectofinanciero_usuario: [
                Cor1440Gen::ProyectofinancieroUsuario.new
              ]
            )
          end

        end # included

      end
    end
  end
end

