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
            @informes = @informes.paginate(
              :page => params[:pagina], per_page: 20
            )
            @cuerpotabla = []
            @enctabla = []
          end

          # GET /informes/1
          def show
            #@actividades = Cor1440Gen::ActividadesController.filtra(params)
            @actividades = Cor1440Gen::Actividad.all
            @numactividades = @actividades.size
            @enctabla = []
            if @informe.columnanombre
              @enctabla << 'Nombre'
            end
            if @informe.columnatipo
              @enctabla << 'Tipo'
            end
            if @informe.columnaobjetivo
              @enctabla << 'Objetivo'
            end
            if @informe.columnaproyecto
              @enctabla << 'Proyecto'
            end
            if @informe.columnapoblacion
              @enctabla << 'Población'
            end
            @cuerpotabla = []
            
            @actividades.try(:each) do |actividad|
              fila = []
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
              redirect_to @informe, notice: 'Informe was successfully created.'
            else
              render :new
            end
          end

          # PATCH/PUT /informes/1
          def update
            if @informe.update(informe_params)
              redirect_to @informe, notice: 'Informe was successfully updated.'
            else
              render :edit
            end
          end

          # DELETE /informes/1
          def destroy
            @informe.destroy
            redirect_to informes_url, notice: 'Informe was successfully destroyed.'
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
              :filtroproyecto, 
              :filtroactividadarea, #:filtropoa, 
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
