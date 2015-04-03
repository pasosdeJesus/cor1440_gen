# encoding: UTF-8

require 'sivel2_gen/concerns/models/caso'

module Sivel2Sjr
  module Concerns
    module Models
      module Caso 
        extend ActiveSupport::Concern
        include Sivel2Gen::Concerns::Models::Caso

        included do
          has_many :actosjr, class_name: 'Sivel2Sjr::Actosjr',
            :through => :acto, dependent: :destroy
          accepts_nested_attributes_for :actosjr, allow_destroy: true, 
            reject_if: :all_blank

          has_one :casosjr, class_name: 'Sivel2Sjr::Casosjr',
            foreign_key: "id_caso", inverse_of: :caso, validate: true, 
            dependent: :destroy
          # respuesta deberìa ser con :through => :casosjr pero más dificil guardar
          has_many :respuesta, class_name: 'Sivel2Sjr::Respuesta',
            foreign_key: "id_caso", validate:true, dependent: :destroy
          accepts_nested_attributes_for :respuesta, allow_destroy: true, 
            reject_if: :all_blank
          accepts_nested_attributes_for :casosjr, allow_destroy: true, 
            update_only: true

          has_many :desplazamiento, class_name: 'Sivel2Sjr::Desplazamiento',
            foreign_key: "id_caso", validate: true, dependent: :destroy
          accepts_nested_attributes_for :desplazamiento , allow_destroy: true, 
            reject_if: :all_blank
          has_many :victimasjr, class_name: 'Sivel2Sjr::Victimasjr',
            :through => :victima, dependent: :destroy
          accepts_nested_attributes_for :victimasjr, allow_destroy: true, 
            reject_if: :all_blank

          validate :rol_usuario
        end



        module ClassMethods
          def refresca_conscaso
            if !ActiveRecord::Base.connection.table_exists? 'sivel2_gen_conscaso'
              ActiveRecord::Base.connection.execute(
                "CREATE OR REPLACE VIEW sivel2_gen_conscaso1 
        AS SELECT casosjr.id_caso as caso_id, 
        ARRAY_TO_STRING(ARRAY(SELECT nombres || ' ' || apellidos 
          FROM sivel2_gen_persona AS persona
          WHERE persona.id=casosjr.contacto), ', ')
          AS contacto_nombre, 
        casosjr.fecharec,
        regionsjr.nombre AS regionsjr_nombre,
        usuario.nusuario,
        caso.fecha AS caso_fecha,
        statusmigratorio.nombre AS statusmigratorio_nombre,
        ARRAY_TO_STRING(ARRAY(SELECT fechaatencion 
          FROM sivel2_sjr_respuesta AS respuesta
          WHERE respuesta.id_caso=casosjr.id_caso 
          ORDER BY fechaatencion DESC LIMIT 1), ', ')
          AS respuesta_ultimafechaatencion,
        caso.memo AS caso_memo
        FROM sivel2_sjr_casosjr AS casosjr, sivel2_gen_caso AS caso, 
          sivel2_gen_regionsjr AS regionsjr, usuario, 
          sivel2_sjr_statusmigratorio AS statusmigratorio
        WHERE casosjr.id_caso = caso.id
          AND regionsjr.id=casosjr.id_regionsjr
          AND usuario.id = casosjr.asesor
          AND statusmigratorio.id = casosjr.id_statusmigratorio"
              )
              ActiveRecord::Base.connection.execute(
                "CREATE MATERIALIZED VIEW sivel2_gen_conscaso 
        AS SELECT caso_id, contacto_nombre, fecharec, regionsjr_nombre, 
          nusuario, caso_fecha, statusmigratorio_nombre,
          respuesta_ultimafechaatencion, caso_memo,
          to_tsvector('spanish', unaccent(caso_id || ' ' || contacto_nombre || 
            ' ' || replace(cast(fecharec AS varchar), '-', ' ') || 
            ' ' || regionsjr_nombre || ' ' || nusuario || ' ' || 
            replace(cast(caso_fecha AS varchar), '-', ' ') || ' ' ||
            statusmigratorio_nombre || ' ' || 
            replace(cast(respuesta_ultimafechaatencion AS varchar), '-', ' ')
            || ' ' || caso_memo )) as q
        FROM sivel2_gen_conscaso1"
              );
              ActiveRecord::Base.connection.execute(
                "CREATE INDEX busca_conscaso ON sivel2_gen_conscaso USING gin(q);"
              )
            else
              ActiveRecord::Base.connection.execute(
                "REFRESH MATERIALIZED VIEW sivel2_gen_conscaso"
              )
            end
          end

          def porsivel2sjr
            "por"
          end

        end


        def rol_usuario
          # current_usuario será nil cuando venga de validaciones por ejemplo
          # validate_presence_of :caso
          # que se hace desde acto
          if (current_usuario &&
              current_usuario.rol != Ability::ROLADMIN &&
              current_usuario.rol != Ability::ROLDIR &&
              current_usuario.rol != Ability::ROLSIST &&
              current_usuario.rol != Ability::ROLCOOR &&
              current_usuario.rol != Ability::ROLANALI) 
            errors.add(:id, "Rol de usuario no apropiado para editar")
          end
          if (current_usuario &&
              current_usuario.rol == Ability::ROLSIST && 
              (casosjr.asesor != current_usuario.id))
            errors.add(:id, "Sistematizador solo puede editar sus casos")
          end
        end

        def iporsivel2sjr
          "por"
        end

      end
    end
  end
end
