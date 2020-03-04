module Cor1440Gen
  module Concerns
    module Models
      module ActividadProyectofinanciero 
        extend ActiveSupport::Concern

        included do

          belongs_to :actividad, class_name: 'Cor1440Gen::Actividad', 
            foreign_key: 'actividad_id'
          belongs_to :proyectofinanciero, 
            class_name: 'Cor1440Gen::Proyectofinanciero',
            foreign_key: 'proyectofinanciero_id'
          attr_accessor :actividadpf_ids
          has_many :actividadpf, 
            class_name: 'Cor1440Gen::Actividadpf', 
            through: :actividad

          def actividadpf_ids
            self.actividad.actividadpf.where(
              proyectofinanciero_id: self.proyectofinanciero_id).pluck(:id)
          end

          def actividadpf_ids=(v)
            if !self.actividad
              puts "OJO SIN ACTIVIDAD_ID"
              return
            end
            if v.respond_to?(:each)
              ant = []
              if self.actividad.actividadpf
                ant = self.actividad.actividadpf.where(
                  proyectofinanciero_id: self.proyectofinanciero_id).pluck(:id)
              end
              # Filtramos v para restringir al proyectofinanciero que se
              # modifica
              vf = Cor1440Gen::Actividadpf.where(
                proyectofinanciero_id: self.proyectofinanciero_id).
                where(id: v).pluck(:id)

              # Por eliminar
              pore = ant-vf
              # Por agregar
              pora = vf-ant
              # Eliminar
              Cor1440Gen::ActividadActividadpf.where(
                actividad_id: self.actividad_id).where(
                  actividadpf_id: pore).delete_all
              # Agregar
              pora.each do |a|
                aa = Cor1440Gen::ActividadActividadpf.create(
                  actividad_id: self.actividad_id,
                  actividadpf_id: a)
                aa.save!
              end
            end
            res = []
            if self.actividad.actividadpf
              res = self.actividad.actividadpf.where(
                proyectofinanciero_id: self.proyectofinanciero_id).pluck(:id)
            end
            res
          end


        end
      end
    end
  end
end

