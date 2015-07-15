# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Controllers
      module ActividadesController
        extend ActiveSupport::Concern

        included do
          before_action :set_actividad, only: [:show, :edit, :update, :destroy]
          load_and_authorize_resource class: Cor1440Gen::Actividad

          # Encabezado comun para HTML y PDF (primeras filas)
          def encabezado_comun
              return [ Cor1440Gen::Actividad.human_attribute_name(:id), 
              @actividades.human_attribute_name(:fecha),
              @actividades.human_attribute_name(:oficina),
              @actividades.human_attribute_name(:nombre),
              @actividades.human_attribute_name(:areas),
              @actividades.human_attribute_name(:tipos),
              @actividades.human_attribute_name(:objetivo),
              @actividades.human_attribute_name(:proyectos),
              @actividades.human_attribute_name(:proyectosfinancieros),
              @actividades.human_attribute_name(:poblacion),
            ]
          end

          def fila_comun(actividad)
            pob = actividad.actividad_rangoedadac.map { |i| 
              (i.ml ? i.ml : 0) + (i.mr ? i.mr : 0) +
                (i.fl ? i.fl : 0) + (i.fr ? i.fr : 0)
            } 
            return [actividad.id,
              actividad.fecha , 
              actividad.oficina ? actividad.oficina.nombre : "",
              actividad.nombre ? actividad.nombre : "",
              actividad.actividadareas.inject("") { |memo, i| 
              (memo == "" ? "" : memo + "; ") + i.nombre },
              actividad.actividadtipo.inject("") { |memo, i| 
              (memo == "" ? "" : memo + "; ") + i.nombre },
              actividad.objetivo , 
              actividad.proyecto.inject("") { |memo, i| 
              (memo == "" ? "" : memo + "; ") + i.nombre },
              actividad.proyectofinanciero.inject("") { |memo, i| 
                (memo == "" ? "" : memo + "; ") + i.nombre },
              pob.reduce(:+)
            ]
          end

          # Cuerpo de tabla comun para HTML y PDF
          def cuerpo_comun
            cuerpo = []
            @actividades.try(:each) do |actividad|
              cuerpo += [fila_comun(actividad)]
            end
            return cuerpo
          end

          # GET /actividades
          # GET /actividades.json
          def index
            @actividades = Cor1440Gen::ActividadesController.filtra(params)
            @numactividades = @actividades.size
            @actividades = @actividades.paginate(
              :page => params[:pagina], per_page: 20
            )
            @enctabla = encabezado_comun()
            @cuerpotabla = cuerpo_comun()
            respond_to do |format|
              format.html { render "index", layout: "application" }
              format.json { head :no_content }
              format.js   { render 'index' }
              format.pdf  { prawnto(prawn: { page_layout: :landscape },
                filename: "actividades-#{Time.now.strftime('%Y-%m-%d')}.pdf", 
                inline: true)
              }
            end
            return
          end

          # GET /actividades/1
          # GET /actividades/1.json
          def show
            @actividades = Actividad.where(id: @actividad.id)
            @enctabla = encabezado_comun()
            @cuerpotabla = cuerpo_comun()
           
            render layout: "application"
          end

          # GET /actividades/new
          def new
            @actividad = Actividad.new
            @actividad.current_usuario = current_usuario
            @actividad.oficina_id = 1
            render layout: "application"
          end

          # GET /actividades/1/edit
          def edit
            render layout: "application"
          end

          # POST /actividades
          # POST /actividades.json
          def create
            @actividad = Actividad.new(actividad_params)
            @actividad.current_usuario = current_usuario
            respond_to do |format|
              if @actividad.save
                format.html { 
                  redirect_to @actividad, notice: 'Actividad creada.' 
                }
                format.json { 
                  render action: 'show', status: :created, location: @actividad 
                }
              else
                format.html { render action: 'new', layout: 'application' }
                format.json { 
                  render json: @actividad.errors, status: :unprocessable_entity 
                }
              end
            end
          end

          # PATCH/PUT /actividades/1
          # PATCH/PUT /actividades/1.json
          def update
            respond_to do |format|
              if @actividad.update(actividad_params)
                format.html { 
                  redirect_to @actividad, notice: 'Actividad actualizada.' 
                }
                format.json { head :no_content }
              else
                format.html { render action: 'edit', layout: 'application' }
                format.json { 
                  render json: @actividad.errors, status: :unprocessable_entity 
                }
              end
            end
          end

          # DELETE /actividades/1
          # DELETE /actividades/1.json
          def destroy
            @actividad.destroy
            respond_to do |format|
              format.html { 
                redirect_to actividades_url, notice: 'Actividad eliminada' }
                format.json { head :no_content }
            end
          end

          private

          def set_actividad
            @actividad = Actividad.find(
              Actividad.connection.quote_string(params[:id]).to_i
            )
            @actividad.current_usuario = current_usuario
          end

          # No confiar parametros a Internet, sólo permitir lista blanca
          def actividad_params
            params.require(:actividad).permit(
              :oficina_id, :minutos, :nombre, 
              :objetivo, :proyecto, :resultado,
              :fecha, :actividad, :observaciones, 
              :usuario_id,
              :lugar,
              :actividadarea_ids => [],
              :actividadtipo_ids => [],
              :proyecto_ids => [],
              :proyectofinanciero_ids => [],
              :usuario_ids => [],
              :actividad_rangoedadac_attributes => [
                :id, :rangoedadac_id, :fl, :fr, :ml, :mr, :_destroy
            ],
              :actividad_sip_anexo_attributes => [
                :id,
                :id_actividad, 
                :_destroy,
                :sip_anexo_attributes => [
                  :id, :descripcion, :adjunto, :_destroy
                ]
              ]
            )
          end
        end

        class_methods do
          def param_escapa(par, p)
            par[p] ? Sip::Pais.connection.quote_string(par[p]) : ''
          end

          def filtra(par)
            ac = Actividad.order(fecha: :desc)
            #byebug
            @buscodigo = param_escapa(par, 'buscodigo')
            if @buscodigo != '' then
              ac = ac.where(id: @buscodigo.to_i)
            end
            @fechaini = param_escapa(par, 'fechaini')
            if @fechaini != '' then
              ac = ac.where("fecha >= '#{@fechaini}'")
            end
            @fechafin = param_escapa(par, 'fechafin')
            if @fechafin != '' then
              ac = ac.where("fecha <= '#{@fechafin}'")
            end
            @busoficina = param_escapa(par, 'busoficina')
            if @busoficina != '' then
              ac = ac.where(oficina_id: @busoficina)
            end
            @busnombre = param_escapa(par, 'busnombre')
            if @busnombre != '' then
              ac = ac.where("nombre ILIKE '%#{@busnombre}%'")
            end
            @busarea = param_escapa(par, 'busarea')
            if @busarea != '' then
              ac = ac.joins(:actividadareas_actividad).where(
                "cor1440_gen_actividadareas_actividad.actividadarea_id = ?",
                @busarea.to_i
              )
            end
            @bustipo = param_escapa(par, 'bustipo')
            if @bustipo != '' then
              ac = ac.joins(:actividad_actividadtipo).where(
                "cor1440_gen_actividad_actividadtipo.actividadtipo_id = ?",
                @bustipo.to_i
              )
            end
            @busobjetivo = param_escapa(par, 'busobjetivo')
            if @busobjetivo != '' then
              ac = ac.where("objetivo ILIKE '%#{@busobjetivo}%'")
            end
            @busproyecto = param_escapa(par, 'busproyecto')
            if @busproyecto != '' then
              ac = ac.joins(:actividad_proyecto).where(
                "cor1440_gen_actividad_proyecto.proyecto_id= ?",
                @busproyecto.to_i
              )
            end
            @busproyectofinanciero = param_escapa(par, 'busproyectofinanciero')
            if @busproyectofinanciero != '' then
              ac = ac.joins(:actividad_proyectofinanciero).where(
                "cor1440_gen_actividad_proyectofinanciero.proyectofinanciero_id= ?",
                @busproyectofinanciero.to_i
              )
            end
            return ac
          end

        end

      end
    end
  end
end


