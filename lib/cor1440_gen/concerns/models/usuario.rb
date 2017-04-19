# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Models
      module Usuario
        extend ActiveSupport::Concern

        included do

          belongs_to :oficina, class_name: 'Sip::Oficina',
            foreign_key: "oficina_id", validate: true

          has_many :proyectofinanciero, 
            class_name: 'Cor1440Gen::Proyectofinanciero',
            foreign_key: 'responsable_id',
            dependent: :delete_all
          has_many :actividad_usuario, dependent: :delete_all,
            class_name: 'Cor1440Gen::ActividadUsuario',
            foreign_key: 'usuario_id'
          has_many :actividad, through: :actividad_usuario,
            class_name: 'Cor1440Gen::Actividad'

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

      end
    end
  end
end

