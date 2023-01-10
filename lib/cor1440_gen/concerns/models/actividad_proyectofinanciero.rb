# frozen_string_literal: true

module Cor1440Gen
  module Concerns
    module Models
      module ActividadProyectofinanciero
        extend ActiveSupport::Concern

        included do
          belongs_to :actividad,
            class_name: "Cor1440Gen::Actividad",
            optional: false
          belongs_to :proyectofinanciero,
            class_name: "Cor1440Gen::Proyectofinanciero",
            optional: false
          attr_accessor :actividadpf_ids

          has_many :actividadpf,
            foreign_key: "proyectofinanciero_id",
            class_name: "Cor1440Gen::Actividadpf",
            through: :actividad

          validates :proyectofinanciero_id, presence: true

          after_destroy do
            # Si hay respuestafor asociada a actividadpf del proyectofinanciero_id que se desasocia eliminarla
            actividad.actividadpf_ids -= proyectofinanciero.actividadpf_ids
          end

          def actividadpf_ids
            actividad.actividadpf.where(
              proyectofinanciero_id: proyectofinanciero_id,
            ).pluck(:id)
          end

          def actividadpf_ids=(v)
            unless actividad
              puts "OJO SIN ACTIVIDAD_ID"
              return
            end
            if v.respond_to?(:each)
              ant = []
              if actividad.actividadpf
                ant = actividad.actividadpf.where(
                  proyectofinanciero_id: proyectofinanciero_id,
                ).pluck(:id)
              end
              # Filtramos v para restringir al proyectofinanciero que se
              # modifica
              vf = Cor1440Gen::Actividadpf.where(
                proyectofinanciero_id: proyectofinanciero_id,
              )
                .where(id: v).pluck(:id)

              # Por eliminar
              pore = ant - vf
              # Por agregar
              pora = vf - ant
              # Eliminar
              Cor1440Gen::ActividadActividadpf.where(
                actividad_id: actividad_id,
              ).where(
                actividadpf_id: pore,
              ).delete_all
              # Agregar
              pora.each do |a|
                aa = Cor1440Gen::ActividadActividadpf.create(
                  actividad_id: actividad_id,
                  actividadpf_id: a,
                )
                aa.save!
              end
            end
            res = []
            if actividad.actividadpf
              res = actividad.actividadpf.where(
                proyectofinanciero_id: proyectofinanciero_id,
              ).pluck(:id)
            end
            res
          end
        end
      end
    end
  end
end
