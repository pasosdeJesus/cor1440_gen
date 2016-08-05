# encoding: UTF-8


module Cor1440Gen
  module Concerns
    module Controllers
      module InformesController 
        extend ActiveSupport::Concern

        included do
          before_action :set_informe, only: [:show, :edit, :update, :destroy]
          load_and_authorize_resource class: Cor1440Gen::Informe

          # GET /informes
          def index
            @informes = Informe.all
            @informes = @informes.order(filtrofechafin: :desc).paginate(
              :page => params[:pagina], per_page: 20
            )
            @cuerpotabla = []
            @enctabla = []
          end

          # Retorna actividades tras aplicar filtro que está en @informe
          def filtra_actividades
            return Cor1440Gen::ActividadesController.filtra({
              fechaini: @informe.filtrofechaini,
              fechafin: @informe.filtrofechafin,
              busresponsable: @informe.filtroresponsable,
              busoficina: @informe.filtrooficina,
              busproyecto: @informe.filtroproyecto,
              busarea: @informe.filtroactividadarea,
              busproyectofinanciero: @informe.filtroproyectofinanciero
            })

          end

          def impreso_extra(r, informe, actividades)
             # r.add_field(:contextointerno, informe.contextointerno)
             # r.add_field(:contextoexterno, informe.contextoexterno)
            return r
          end

          def impreso
            @informe = Informe.find(@informe.id)
            @actividades = filtra_actividades

            # Ejemplo de https://github.com/sandrods/odf-report
            report = ::ODFReport::Report.new("#{Rails.root}/app/reportes/Plantilla-InformeActividades.odt") do |r|
              r.add_field(:titulo, @informe.titulo)
              r.add_field(:fecha, Date.today)
              r.add_field(:numact, @actividades.size)
              r.add_table("ACTIVIDADES", @actividades) do |t|
                t.add_column(:nombreact) { |ac| "#{ac.nombre}" }
                t.add_column(:tipoact) { |ac| 
                  ac.actividadtipo.inject("") { |memo, i| 
                    (memo == "" ? "" : memo + "; ") + i.nombre }
                }
                t.add_column(:objetivoact) { |ac| "#{ac.objetivo}" }
                t.add_column(:proyectoact) { |ac| 
                  ac.proyectofinanciero.inject("") { |memo, i| 
                    (memo == "" ? "" : memo + "; ") + i.nombre }
                }
                t.add_column(:pobact) { |ac| 
                  pob = ac.actividad_rangoedadac.map { |i| 
                    (i.ml ? i.ml : 0) + (i.mr ? i.mr : 0) +
                      (i.fl ? i.fl : 0) + (i.fr ? i.fr : 0)
                  } 
                  pob.reduce(:+)
                }
              end
              r.add_field(:filtro, @informe.gen_descfiltro)
              r.add_field(:recomendaciones, @informe.recomendaciones)
              r.add_field(:avances, @informe.avances)
              r.add_field(:logros, @informe.logros)
              r.add_field(:dificultades, @informe.dificultades)
              r = impreso_extra(r, @informe, @actividades)
            end

            send_data report.generate, type: 'application/vnd.oasis.opendocument.text',
              disposition: 'attachment',
              filename: 'InformeActividades.odt'
          end

          def completa_encabezado(enctabla)
          end
          
          def completa_fila(actividad, fila)
          end

          # GET /informes/1
          def show
            #@actividades = Cor1440Gen::Actividad.all
            @actividades = filtra_actividades
            @numactividades = @actividades.size
            @enctabla = []

            @enctabla << Cor1440Gen::Actividad.
              human_attribute_name(:fecha) if @informe.columnafecha

            @enctabla << Cor1440Gen::Actividad.human_attribute_name(
              :responsable) if @informe.columnaresponsable

            @enctabla << Cor1440Gen::Actividad.
              human_attribute_name(:nombre) if @informe.columnanombre 
            
            @enctabla << Cor1440Gen::Actividad.
              human_attribute_name(:tipoactividad) if @informe.columnatipo

            @enctabla << Cor1440Gen::Actividad.
              human_attribute_name(:objetivo) if @informe.columnaobjetivo
            
            @enctabla << Cor1440Gen::Actividad.
              human_attribute_name(:proyecto) if @informe.columnaproyecto
           
            @enctabla << Cor1440Gen::Actividad.
              human_attribute_name(:poblacion) if @informe.columnapoblacion

            completa_encabezado(@enctabla)
            @cuerpotabla = []
            
            @actividades.try(:each) do |actividad|
              fila = []
              fila << actividad.fecha if @informe.columnafecha
              if  @informe.columnaresponsable 
                fila << (actividad.responsable ? 
                         actividad.responsable.nombre : '')
              end 
              if @informe.columnanombre
                fila << actividad.nombre
              end
              if @informe.columnatipo
                fila << actividad.actividadtipo.inject("") { |memo, i| 
                  (memo == "" ? "" : memo + "; ") + i.nombre }
              end
              if @informe.columnaobjetivo
                fila << actividad.objetivo
              end
              if @informe.columnaproyecto && actividad.proyecto
                fila << actividad.proyecto.inject("") { |memo, i| 
                  (memo == "" ? "" : memo + "; ") + i.nombre }
              end
              if @informe.columnapoblacion
                pob = actividad.actividad_rangoedadac.map { |i| 
                  (i.ml ? i.ml : 0) + (i.mr ? i.mr : 0) +
                    (i.fl ? i.fl : 0) + (i.fr ? i.fr : 0)
                } 
                fila << pob.reduce(:+)
              end
              completa_fila(actividad, fila)
              @cuerpotabla << fila
            end
            #byebug
          end

          # GET /informes/new
          def new
            @informe = Informe.new
          end

          # GET /informes/1/edit
          def edit
          end

          # POST /informes
          def create
            @informe = Informe.new(informe_params)

            if @informe.save
              redirect_to @informe, notice: 'Informe creado.'
            else
              render :new
            end
          end

          # PATCH/PUT /informes/1
          def update
            if @informe.update(informe_params)
              redirect_to @informe, notice: 'Informe actualizado.'
            else
              render :edit
            end
          end

          # DELETE /informes/1
          def destroy
            @informe.destroy
            redirect_to informes_url, notice: 'Informe eliminado.'
          end

          private
          # Use callbacks to share common setup or constraints between actions.
          def set_informe
            @informe = Informe.find(params[:id])
          end

          # Only allow a trusted parameter "white list" through.
          def informe_params
            r = params.require(:informe).permit(
              :titulo, :filtrofechaini, :filtrofechafin, 
              :filtroresponsable, :filtrooficina,
              :filtroproyecto, 
              :filtroactividadarea, #:filtropoa, 
              :filtroproyectofinanciero, 
              :columnafecha, :columnaresponsable, 
              :columnanombre, :columnatipo, 
              :columnaobjetivo, :columnaproyecto, :columnapoblacion, 
              :recomendaciones, :avances, :logros, :dificultades
            )
            return r
          end

        end

      end
    end
  end
end
