# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Controllers
      module ActividadesController
        extend ActiveSupport::Concern

        included do

          before_action :set_actividad, only: [:show, :edit, :update, :destroy]
          load_and_authorize_resource class: Cor1440Gen::Actividad


          def clase
            "Cor1440Gen::Actividad"
          end

          def atributos_index
            [ :id, 
              :fecha_localizada, 
              :oficina, 
              :responsable,
              :nombre, 
              :actividadpf, 
              :proyectos,
              :actividadareas,
              :proyectosfinancieros,
              :objetivo,
              :poblaacion
            ]
          end

          def atributos_form
            atributos_index - [:id]
          end

          def atributos_show
            [ :id, :fecha, :oficina, :responsable,
              :nombre, :actividadpf, :proyectos,
              :actividadareas, :proyectosfinancieros, :objetivo,
              :poblacion,
              ]
          end

          def gencalse
            return 'F'
          end

          def show
            authorize! :read, clase.constantize
            @registro = clase.constantize.find(params[:id])
            render :show, layout: 'application'
          end


          def fila_comun(actividad)
           pob = actividad.actividad_rangoedadac.map { |i| 
              (i.ml ? i.ml : 0) + (i.mr ? i.mr : 0) +
                (i.fl ? i.fl : 0) + (i.fr ? i.fr : 0)
            } 
            return [actividad.id,
                    actividad.fecha , 
                    actividad.oficina ? actividad.oficina.nombre : "",
                    actividad.responsable ? actividad.responsable.nusuario : "",
                    actividad.nombre ? actividad.nombre : "",
                    actividad.actividadpf.inject("") { |memo, i| 
                      (memo == "" ? "" : memo + "; ") + i.titulo },
                    actividad.proyecto.inject("") { |memo, i| 
                        (memo == "" ? "" : memo + "; ") + i.nombre },
                    actividad.actividadareas.inject("") { |memo, i| 
                          (memo == "" ? "" : memo + "; ") + i.nombre },
                    actividad.proyectofinanciero.inject("") { |memo, i| 
                            (memo == "" ? "" : memo + "; ") + i.nombre },
                    actividad.objetivo, 
                    pob.reduce(:+)
            ]
          end

          # transforma un vector devuelto por fila_comun en registro y
          # lo amplia para devolver todo campo consultable de un actividad
          def vector_a_registro(a, ac)
            {
              id: a[0],
              fecha: a[1],
              oficina: a[2],
              responsable: a[3],
              nombre: a[4],
              tipos_de_actividad: a[5],
              areas: a[6],
              subareas: a[7],
              convenios_financieros: a[8],
              objetivo: a[9],
              poblacion: a[10],
              observaciones: ac.observaciones,
              resultado: ac.resultado,
              creacion: ac.created_at,
              actualizacion: ac.updated_at,
              lugar: ac.lugar,
              corresponsables: ac.usuario.inject("") { |memo, i| 
                (memo == "" ? "" : memo + "; ") + i.nusuario },
            }
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
          def index(c = nil)
            super(c)
            return
            #Falta manejar pdf, json, ods como 
            @registros = @actividades = 
              Cor1440Gen::ActividadesController.filtra(
              params[:filtro], current_usuario)
            @plantillas = Heb412Gen::Plantillahcm.where(
              vista: 'Actividad').select('nombremenu, id').map { 
                |c| [c.nombremenu, c.id] }
              @numactividades = @actividades.size
              @enctabla = encabezado_comun()
              respond_to do |format|
                format.html { 
                  @registros = @actividades = @actividades.paginate(
                    :page => params[:pagina], per_page: 20
                  )
                  @cuerpotabla = cuerpo_comun()
                  render "index", layout: "application" 
                }
                format.json { head :no_content }

                format.ods {
                  if params[:idplantilla].nil? 
                    head :no_content 
                  elsif params[:idplantilla].to_i <= 0
                    head :no_content 
                  elsif Heb412Gen::Plantillahcm.where(
                    id: params[:idplantilla].to_i).take.nil?
                    head :no_content 
                  end

                  @cuerpotabla = cuerpo_comun()
                  aractividades = Array.new
                  @cuerpotabla.each do |a| 
                    ac = Cor1440Gen::Actividad.find(a[0])
                    r = vector_a_registro(a, ac)
                    aractividades << r
                  end
                  pl = Heb412Gen::Plantillahcm.find(
                    params[:idplantilla].to_i)
                  n = Heb412Gen::PlantillahcmController.
                    llena_plantilla_multiple_fd(pl, aractividades)
                  send_file n, x_sendfile: true
                }

                format.js   { 
                  @registros = @actividades = @actividades.paginate(
                    :page => params[:pagina], per_page: 20
                  )
                  @cuerpotabla = cuerpo_comun()
                  render 'index' 
                }
                format.pdf  { 
                  @cuerpotabla = cuerpo_comun()
                  prawnto(prawn: { page_layout: :landscape },
                          filename: 
                          "actividades-#{Time.now.strftime('%Y-%m-%d')}.pdf", 
                  inline: true)
                }
              end
              return
          end

          # GET /actividades/new
          def new
            @registro = @actividad = Actividad.new
            @registro.current_usuario = current_usuario
            @registro.oficina_id = current_usuario && 
              current_usuario.oficina_id ? current_usuario.oficina_id : 1
            @registro.save!(validate: false)
            redirect_to cor1440_gen.edit_actividad_path(@registro)
          end


          def asegura_camposdinamicos(actividad)
            ci = []
            actividad.actividadpf.each do |apf|
              ci += apf.actividadtipo.campoact.map(&:id).sort
            end
            ci = ci.sort
            cd = actividad.valorcampoact.map(&:campoact_id).sort
            sobran = cd - ci
            sobran.each do |i|
              if i then
                r = Cor1440Gen::Valorcampoact.where(
                  'actividad_id = ? AND campoact_id = ?', 
                  actividad.id, i).take
              else
                r = Cor1440Gen::Valorcampoact.where(
                  'actividad_id = ? AND campoact_id IS NULL',
                  actividad.id).take
              end
              r.delete
            end
            faltan = ci - cd
            faltan.each do |i|
              nr = Cor1440Gen::Valorcampoact.new
              nr.campoact_id = i
              nr.actividad_id = actividad.id
              nr.valor = ''
              if !nr.save
                puts "No pudo guardar nr"
              end
            end
          end

          # GET /actividades/1/edit
          def edit
            authorize! :edit, Cor1440Gen::Actividad
            @registro = Cor1440Gen::Actividad.find(params[:id])
            if params['actividadpf_ids']
              @registro.actividadpf_ids = params['actividadpf_ids']
            end
            asegura_camposdinamicos(@registro)
            render layout: 'application'
          end

          private

          def set_actividad
            @registro = @actividad = Actividad.find(
              Actividad.connection.quote_string(params[:id]).to_i
            )
            @actividad.current_usuario = current_usuario
          end

          # No confiar parametros a Internet, sólo permitir lista blanca
          def actividad_params
            params.require(:actividad).permit(
              :actividad,
              :fecha_localizada, 
              :lugar,
              :nombre, 
              :objetivo,  
              :observaciones, 
              :oficina_id, 
              :proyecto, 
              :resultado,
              :usuario_id,
              :actividad_sip_anexo_attributes => [
                :id,
                :id_actividad, 
                :_destroy,
                :sip_anexo_attributes => [
                  :id, :descripcion, :adjunto, :_destroy
                ]
              ],
              :actividadarea_ids => [],
              :actividadpf_ids => [],
              :actividad_rangoedadac_attributes => [
                :id, :rangoedadac_id, :fl, :fr, :ml, :mr, :_destroy
              ],
              :valorcampoact_attributes => [
                :id,
                :campoact_id,
                :valor
              ],
              :proyecto_ids => [],
              :proyectofinanciero_ids => [],
              :usuario_ids => []
            )
          end
          

          def actividad_actividadpf_params(nparams)
            nparams.require(:actividad).permit(
              :actividadpf_ids => []
            )
          end

        end # included do



        class_methods do
          def param_escapa(par, p)
            par.nil? ? '' :
            par[p] ? Sip::Pais.connection.quote_string(par[p].to_s) : 
              par[p.to_sym] ? Sip::Pais.connection.quote_string(par[p.to_sym].to_s) :
              par[p.to_s] ? Sip::Pais.connection.quote_string(par[p.to_s].to_s) :  ''
          end

          def filtra(par, current_usuario = nil)
            ac = Actividad.order(fecha: :desc)
            @buscodigo = param_escapa(par, 'buscodigo')
            if @buscodigo != '' then
              ac = ac.where(id: @buscodigo.to_i)
            end
            @fechaini = Sip::FormatoFechaHelper.fecha_local_estandar(
              param_escapa(par, 'fechaini'))
            if @fechaini != '' then
              ac = ac.where("fecha >= '#{@fechaini}'")
            end
            @fechafin = Sip::FormatoFechaHelper.fecha_local_estandar(
              param_escapa(par, 'fechafin'))
            if @fechafin != '' then
              ac = ac.where("fecha <= '#{@fechafin}'")
            end
            @busoficina = param_escapa(par, 'busoficina')
            if @busoficina != '' then
              ac = ac.where(oficina_id: @busoficina)
            end
            @busresponsable = param_escapa(par, 'busresponsable')
            if @busresponsable != '' then
              ac = ac.where(responsable: @busresponsable)
            end
            @busnombre = param_escapa(par, 'busnombre')
            if @busnombre != '' then
              ac = ac.where("unaccent(nombre) ILIKE unaccent(?)", "%#{@busnombre}%")
            end
            @busarea = param_escapa(par, 'busarea')
            if @busarea != '' then
              ac = ac.joins(:actividadareas_actividad).where(
                "cor1440_gen_actividadareas_actividad.actividadarea_id = ?",
                @busarea.to_i
              )
            end
            @busactividadpf= param_escapa(par, 'busactividadpf')
            if @busactividadpf != '' then
              ac = ac.joins(:actividad_actividadpf).where(
                "cor1440_gen_actividad_actividadpf.actividadpf_id = ?",
                @busactividadpf.to_i
              )
            end
            @busobjetivo = param_escapa(par, 'busobjetivo')
            if @busobjetivo != '' then
              ac = ac.where("unaccent(objetivo) ILIKE unaccent(?)", "%#{@busobjetivo}%")
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
            ac = filtramas(par, ac, current_usuario)
            return ac
          end

        end

      end
    end
  end
end


