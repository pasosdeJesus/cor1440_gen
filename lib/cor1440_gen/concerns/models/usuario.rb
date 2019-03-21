# encoding: UTF-8

require 'mr519_gen/concerns/models/usuario'


module Cor1440Gen
  module Concerns
    module Models
      module Usuario
        extend ActiveSupport::Concern

        included do
          include Mr519Gen::Concerns::Models::Usuario

          belongs_to :oficina, class_name: 'Sip::Oficina',
            foreign_key: "oficina_id", validate: true

          has_and_belongs_to_many :actividad, 
            foreign_key: 'usuario_id',
            class_name: 'Cor1440Gen::Actividad',
            association_foreign_key: 'actividad_id',
            join_table: 'cor1440_gen_actividad_usuario'

          has_many :filtroresponsable, 
            class_name: 'Cor1440Gen::Informe',
            foreign_key: 'filtroresponsable',
            dependent: :delete_all
          has_many :proyectofinanciero, 
            class_name: 'Cor1440Gen::Proyectofinanciero',
            foreign_key: 'responsable_id',
            dependent: :delete_all

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

          scope :filtro_oficina_id, lambda {|o|
            where(oficina_id: o)
          }

        end

      end
    end
  end
end

