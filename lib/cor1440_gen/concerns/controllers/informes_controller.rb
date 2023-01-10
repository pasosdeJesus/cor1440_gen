# frozen_string_literal: true

module Cor1440Gen
  module Concerns
    module Controllers
      module InformesController
        extend ActiveSupport::Concern

        included do
          # GET /informes
          def index
            @informes = Informe.all
            @informes = @informes.order(filtrofechafin: :desc).paginate(
              page: params[:pagina], per_page: 20,
            )
            @cuerpotabla = []
            @enctabla = []
          end

          # Retorna actividades tras aplicar filtro que está en @informe
          def filtra_actividades
            c = Cor1440Gen::ActividadesController.new
            a = Cor1440Gen::Actividad.all
            params_filtro = {
              "busfecha_localizadaini" => @informe.filtrofechaini.to_s,
              # El control de fecha HTML estándar --usado en el filtro de
              # actividad-- retorna la fecha en formato yyyy-mm-dd
              "busfecha_localizadafin" => @informe.filtrofechafin.to_s,
              "busresponsable" => @informe.filtroresponsable,
              "busoficina" => @informe.filtrooficina,
              "busproyecto" => @informe.filtroproyecto,
              "busarea" => @informe.filtroactividadarea,
              "busproyectofinanciero" => @informe.filtroproyectofinanciero,
            }
            a = c.filtrar(a, params_filtro)
            a
            # Cor1440Gen::ActividadesController.filtra({ }, current_usuario)
          end

          def impreso_extra(r, informe, actividades)
            # r.add_field(:contextointerno, informe.contextointerno)
            # r.add_field(:contextoexterno, informe.contextoexterno)
            r
          end

          def impreso
            @informe = Informe.find(@informe.id)
            @actividades = filtra_actividades

            # Ejemplo de https://github.com/sandrods/odf-report
            report = ::ODFReport::Report.new("#{Rails.root}/app/reportes/Plantilla-InformeActividades.odt") do |r|
              r.add_field(:titulo, @informe.titulo)
              r.add_field(:fecha, Date.today)
              r.add_field(
                :numact,
                ActionController::Base.helpers.pluralize(
                  @actividades.size, "actividad", plural: "actividades"
                ),
              )
              r.add_table("ACTIVIDADES", @actividades) do |t|
                t.add_column(:fechaact) { |ac| "#{ac.fecha}" }
                t.add_column(:responsableact) do |ac|
                  ac.responsable ? ac.responsable.nusuario : ""
                end
                t.add_column(:nombreact) { |ac| "#{ac.nombre}" }
                t.add_column(:tipoact) do |ac|
                  ac.actividadtipo.inject("") do |memo, i|
                    (memo == "" ? "" : memo + "; ") + i.nombre
                  end
                end
                t.add_column(:objetivoact) { |ac| "#{ac.objetivo}" }
                t.add_column(:proyectoact) do |ac|
                  ac.proyectofinanciero.inject("") do |memo, i|
                    (memo == "" ? "" : memo + "; ") + i.nombre
                  end
                end
                t.add_column(:pobact) do |ac|
                  pob = ac.actividad_rangoedadac.map do |i|
                    (i.ml ? i.ml : 0) + (i.mr ? i.mr : 0) +
                      (i.fl ? i.fl : 0) + (i.fr ? i.fr : 0)
                  end
                  pob.reduce(:+)
                end
              end
              r.add_field(:filtro, @informe.gen_descfiltro)
              r.add_field(:recomendaciones, @informe.recomendaciones)
              r.add_field(:avances, @informe.avances)
              r.add_field(:logros, @informe.logros)
              r.add_field(:dificultades, @informe.dificultades)
              r = impreso_extra(r, @informe, @actividades)
            end

            send_data(
              report.generate,
              # type: 'application/vnd.oasis.opendocument.text',
              disposition: "attachment",
              filename: "InformeActividades.odt",
            )
          end

          def completa_encabezado(enctabla)
          end

          def completa_fila(actividad, fila)
          end

          # GET /informes/1
          def show
            # @actividades = Cor1440Gen::Actividad.all
            @actividades = filtra_actividades
            @numactividades = @actividades.size
            @enctabla = []

            @enctabla << Cor1440Gen::Actividad
              .human_attribute_name(:fecha) if @informe.columnafecha

            @enctabla << Cor1440Gen::Actividad.human_attribute_name(
              :responsable,
            ) if @informe.columnaresponsable

            @enctabla << Cor1440Gen::Actividad
              .human_attribute_name(:nombre) if @informe.columnanombre

            @enctabla << Cor1440Gen::Actividad
              .human_attribute_name(:tipoactividad) if @informe.columnatipo

            @enctabla << Cor1440Gen::Actividad
              .human_attribute_name(:objetivo) if @informe.columnaobjetivo

            @enctabla << Cor1440Gen::Actividad
              .human_attribute_name(:proyecto) if @informe.columnaproyecto

            @enctabla << Cor1440Gen::Actividad
              .human_attribute_name(:poblacion) if @informe.columnapoblacion

            completa_encabezado(@enctabla)
            @cuerpotabla = []

            @actividades.try(:each) do |actividad|
              fila = []
              fila << actividad.fecha if @informe.columnafecha
              if @informe.columnaresponsable && actividad.responsable
                fila << actividad.responsable.nusuario
              end
              if @informe.columnanombre
                fila << actividad.nombre
              end
              if @informe.columnatipo
                fila << actividad.actividadtipo.inject("") do |memo, i|
                  (memo == "" ? "" : memo + "; ") + i.nombre
                end
              end
              if @informe.columnaobjetivo
                fila << actividad.objetivo
              end
              if @informe.columnaproyecto && actividad.proyecto
                fila << actividad.proyecto.inject("") do |memo, i|
                  (memo == "" ? "" : memo + "; ") + i.nombre
                end
              end
              if @informe.columnapoblacion
                pob = actividad.actividad_rangoedadac.map do |i|
                  (i.ml ? i.ml : 0) + (i.mr ? i.mr : 0) +
                    (i.fl ? i.fl : 0) + (i.fr ? i.fr : 0)
                end
                fila << pob.reduce(:+)
              end
              completa_fila(actividad, fila)
              @cuerpotabla << fila
            end
            # byebug
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
              redirect_to(@informe, notice: "Informe creado.")
            else
              render(:new)
            end
          end

          # PATCH/PUT /informes/1
          def update
            if @informe.update(informe_params)
              redirect_to(@informe, notice: "Informe actualizado.")
            else
              render(:edit)
            end
          end

          # DELETE /informes/1
          def destroy
            @informe.destroy
            redirect_to(informes_url, notice: "Informe eliminado.")
          end

          private

          # Use callbacks to share common setup or constraints between actions.
          def set_informe
            @informe = Informe.find(params[:id])
          end

          # Only allow a trusted parameter "white list" through.
          def informe_params
            r = params.require(:informe).permit(
              :titulo,
              :filtrofechaini,
              :filtrofechaini_localizada,
              :filtrofechafin,
              :filtrofechafin_localizada,
              :filtroresponsable,
              :filtrooficina,
              :filtroproyecto,
              :filtroactividadarea, # :filtropoa,
              :filtroproyectofinanciero,
              :columnafecha,
              :columnaresponsable,
              :columnanombre,
              :columnatipo,
              :columnaobjetivo,
              :columnaproyecto,
              :columnapoblacion,
              :recomendaciones,
              :avances,
              :logros,
              :dificultades,
            )
            r
          end
        end
      end
    end
  end
end
