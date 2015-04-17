# encoding: UTF-8

require 'sip/concerns/models/usuario'

module Cor1440Gen
  module Concerns
    module Models
      module Usuario
        extend ActiveSupport::Concern
        include Sip::Concerns::Models::Usuario

        included do
       #   has_many :etiqueta_usuario, class_name: 'Cor1440Gen::EtiquetaUsuario',
       #     dependent: :delete_all
       #   has_many :etiqueta, class_name: 'Sip::Etiqueta',
       #     through: :etiqueta_usuario

          belongs_to :oficina, class_name: 'Sip::Oficina',
            foreign_key: "oficina_id", validate: true

          validate :rol_usuario
          def rol_usuario
            if oficina && (rol == Ability::ROLADMIN ||
                             rol == Ability::ROLINV || 
                             rol == Ability::ROLDIR)
              errors.add(:oficina, "Oficina debe estar en blanco para el rol elegido")
            end
            if !oficina && rol != Ability::ROLADMIN && rol != Ability::ROLINV && 
              rol != Ability::ROLDIR
              errors.add(:oficina, "El rol elegido debe tener oficina")
            end
            #    if (etiqueta.count == 0 && rol == Ability::ROLINV) 
            #      errors.add(:etiqueta, "El rol invitado debe tener etiquetas compartir")
            #    end
            #if (etiqueta.count != 0 && rol != Ability::ROLINV) 
            #  errors.add(:etiqueta, "El rol elegido no requiere etiquetas de compartir")
            #end
            if (!current_usuario.nil? && current_usuario.rol == Ability::ROLCOOR)
              if (oficina.nil? || 
                  oficina.id != current_usuario.oficina_id)
                errors.add(:oficina, "Solo puede editar usuarios de su oficina")
              end
            end
          end
        end

        module ClassMethods
        end

      end
    end
  end
end
