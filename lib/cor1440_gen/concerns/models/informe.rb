module Cor1440Gen
  module Concerns
    module Models
      module Informe
        extend ActiveSupport::Concern

        included do
          include Msip::Localizacion

          belongs_to :proyecto, class_name: 'Cor1440Gen::Proyecto',
            foreign_key: 'filtroproyecto', validate: true, optional: true
          belongs_to :actividadarea, 
            class_name: 'Cor1440Gen::Actividadarea', 
            foreign_key: 'filtroactividadarea', validate: true, optional: true
          belongs_to :proyectofinanciero, 
            class_name: 'Cor1440Gen::Proyectofinanciero', 
            foreign_key: 'filtroproyectofinanciero', validate: true, 
            optional: true
          belongs_to :responsable, 
            class_name: '::Usuario', 
            foreign_key: 'filtroresponsable', validate: true, optional: true
          belongs_to :oficina, 
            class_name: 'Msip::Oficina', 
            foreign_key: 'filtrooficina', validate: true, optional: true



          validates :titulo, presence: true
          validates :filtrofechaini, presence: true
          validates :filtrofechafin, presence: true

          campofecha_localizado :filtrofechaini
          campofecha_localizado :filtrofechafin

          scope :filtro_nombre, lambda { |n|
            where("unaccent(#{table_name}.nombre) ILIKE '%' || unaccent(?) || '%'", n)
          }

          def new(*args, &block)
            super(*args, block)
          end

          # Para sobrecargar
          def gen_descfiltro_post(descfiltro)
            return descfiltro
          end 

          def gen_descfiltro
            descfiltro=''
            if (filtrofechaini && !filtrofechafin) 
              descfiltro += 'Después de ' + filtrofechaini.to_s + ".  "
            end
            if (!filtrofechaini && filtrofechafin) 
              descfiltro += 'Antes de ' + filtrofechaini.to_s + ".  "
            end
            if (filtrofechaini && filtrofechafin) 
              descfiltro  += 'Entre ' + filtrofechaini.to_s + " y " + 
                filtrofechafin.to_s + ".  "
            end
            if (responsable)
              descfiltro += "Responsable #{responsable.presenta_nombre}.  "
            end
            if (oficina)
              descfiltro += "Oficina #{oficina.nombre}.  "
            end
            if (proyectofinanciero)
              descfiltro += "Del #{Cor1440Gen::Actividad.human_attribute_name(:proyectofinanciero)} #{proyectofinanciero.nombre}.  "
            end
            if (proyecto)
              descfiltro += "Del #{Cor1440Gen::Actividad.human_attribute_name(:proyecto)} #{proyecto.nombre}.  "
            end
            if (actividadarea)
              descfiltro += "De la #{Cor1440Gen::Actividad.human_attribute_name(:actividadarea)} #{actividadarea.nombre}.  "
            end

            return gen_descfiltro_post(descfiltro)
          end
        end

      end
    end
  end
end
