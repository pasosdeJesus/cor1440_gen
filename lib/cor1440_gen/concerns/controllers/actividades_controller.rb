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

          def genclase
            return 'F'
          end

          def atributos_index
            [ :id, 
              :fecha_localizada, 
              :oficina, 
              :responsable,
              :nombre, 
              :proyecto,
              :actividadareas,
              :proyectofinanciero,
              :actividadpf, 
              :objetivo,
              :poblacion,
              :anexos
            ]
          end

          def atributos_form
            atributos_show - [:id]
          end

          def atributos_show
            [ :id, 
              :nombre, 
              :fecha_localizada, 
              :lugar, 
              :oficina, 
              :proyectofinanciero, 
              :proyectos,
              :actividadareas, 
              :responsable,
              :corresponsables,
              :actividadpf, 
              :respuestafor,
              :objetivo,
              :resultado, 
              :actorsocial,
              :listadoasistencia,
              :poblacion,
              :anexos
              ]
          end

          def cuenta
            #@misgrupos = Cor1440Gen::GruposHelper.
            #  mis_grupos_sinus(current_usuario) 
            # Investigadores ven sólo su linea
            #mg = @misgrupos.where("nombre LIKE '#{::Ability::GRUPO_LINEA}%'").
            #  order(:nombre)
            #if mg.count > 0 && mg.count < 3
            #  @misgrupos = mg
            #end
            #@miscompromisos = Cor1440Gen::GruposHelper.
            #  compromisos_grupos(Cor1440Gen::Proyectofinanciero.all,
            #                     @misgrupos)
            @pfid = params[:filtro] && params[:filtro][:proyectofinanciero_id] ? 
              params[:filtro][:proyectofinanciero_id].to_i : 18  
            @baseactividad = Cor1440Gen::Actividad.all
            grupo = nil
            if params[:filtro] && params[:filtro][:grupo_id] && 
                params[:filtro][:grupo_id] != ""
              grupo = Sip::Grupo.find(params[:filtro][:grupo_id].to_i)
            else 
              if mg.count == 1
                grupo = mg.first
              end
            end
            if grupo
              @grupoid = grupo.id
              @baseactividad = @baseactividad.where(
                'cor1440_gen_actividad.id IN (SELECT actividad_id 
             FROM actividad_grupo WHERE grupo_id = ?)', @grupoid)
            end

            if !params[:filtro] || !params[:filtro]['fechaini'] || 
                params[:filtro]['fechaini'] != ""
              if !params[:filtro] || !params[:filtro]['fechaini']
                @fechaini = inicio_semestre_ant
              else
                @fechaini = fecha_local_estandar(params[:filtro]['fechaini'])
              end
              @baseactividad = @baseactividad.where(
                'cor1440_gen_actividad.fecha >= ?', @fechaini)
            end
            if !params[:filtro] || !params[:filtro]['fechafin'] || 
                params[:filtro]['fechafin'] != ""
              if !params[:filtro] || !params[:filtro]['fechafin']
                @fechafin = fin_semestre_ant
              else
                @fechafin = fecha_local_estandar(params[:filtro]['fechafin'])
              end
              @baseactividad = @baseactividad.where(
                'cor1440_gen_actividad.fecha <= ?', @fechafin)
            end

            respond_to do |format|
              format.html { render layout: 'application' }
              format.json { head :no_content }
              format.js { render }
            end
          end

          def vistas_manejadas
            ['Actividad']
          end

          def index_reordenar(c)
            c = c.reorder('cor1440_gen_actividad.fecha DESC')
            return c
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
            @listadoasistencia = false
            #ci = []
            vfid = []
            actividad.actividadpf.each do |apf|
              if apf.actividadtipo
                if apf.actividadtipo.listadoasistencia
                  @listadoasistencia = true
                end
                apf.actividadtipo.formulario.each do |f|
                  vfid << f.id
                  aw = actividad.respuestafor.where(formulario_id: f.id) 
                  if  aw.count == 0
                    rf = Mr519Gen::Respuestafor.create(
                      formulario_id: f.id,
                      fechaini: Date.today,
                      fechacambio: Date.today)
                    ar = Cor1440Gen::ActividadRespuestafor.create(
                      actividad_id: actividad.id,
                      respuestafor_id: rf.id,
                    )
                  else # aw.count == 1
                    r = actividad.respuestafor.where(formulario_id: f.id).take
                    ar = Cor1440Gen::ActividadRespuestafor.where(
                      actividad_id: actividad.id,
                      respuestafor_id: r.id,
                    ).take
                  end
                  Mr519Gen::ApplicationHelper::asegura_camposdinamicos(ar)
                end
              end
            end
            if vfid.count > 0
              ar = Cor1440Gen::ActividadRespuestafor.
                where(actividad_id: actividad.id).
                joins(:respuestafor).
                where("formulario_id NOT IN (#{vfid.join(', ')})")
            else vfid.count == 0
              ar = Cor1440Gen::ActividadRespuestafor.
                where(actividad_id: actividad.id)
            end
            if ar.count > 0
              rb = ar.map(&:respuestafor_id)
              Cor1440Gen::ActividadRespuestafor.connection.
                execute("DELETE FROM cor1440_gen_actividad_respuestafor
                        WHERE actividad_id=#{actividad.id} 
                        AND respuestafor_id IN (#{rb.join(', ')})")
              Mr519Gen::Respuestafor.where(id: rb).destroy_all
            end
          end


          def edit_cor1440_gen
            @actividad = @registro = Cor1440Gen::Actividad.find(params[:id])
            authorize! :edit, @registro
            if params['actividadpf_ids']
              @registro.actividadpf_ids = params['actividadpf_ids']
            end
            asegura_camposdinamicos(@registro)
            @registro.save!(validate: false)
          end

          # GET /actividades/1/edit
          def edit
            edit_cor1440_gen
            render layout: 'application'
          end

          def update
            if actividad_params[:asistencia_attributes]
              actividad_params[:asistencia_attributes].each do |a|
                # Ubicamos los de autocompletacion y para esos creamos un registro 
                if a[1] && a[1][:id] && a[1][:id] == '' && 
                    a[1][:persona_attributes] && 
                    a[1][:persona_attributes][:id] &&
                    a[1][:persona_attributes][:id].to_i > 0 &&
                    Sip::Persona.where(
                      id: a[1][:persona_attributes][:id].to_i).count == 1
                  ac = Cor1440Gen::Asistencia.create({
                    actividad_id: @actividad.id,
                    persona_id: a[1][:persona_attributes][:id]
                  })
                  ac.save!(validate: false)
                  params[:actividad][:asistencia_attributes][a[0].to_s][:id] = ac.id
                end
              end
            end
            update_gen
          end
          # Llamado por control para presentar responsables en formulario
          # Para limitar por permisos
          def filtra_usuario_responsable(lista_usuarios)
            if Rails.configuration.x.cor1440_permisos_por_oficina && 
              current_usuario.oficina_id 
              lista_usuarios = lista_usuarios.
                where(oficina_id: current_usuario.oficina_id)
            end
            return lista_usuarios
          end
          helper_method :filtra_usuario_responsable

          private

          def set_actividad
            @registro = @actividad = Actividad.find(
              Actividad.connection.quote_string(params[:id]).to_i
            )
            @actividad.current_usuario = current_usuario
          end

          def lista_params_cor1440_gen
            [ 
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
              :actividadtipo_ids => [],
              :actorsocial_ids => [],
              :asistencia_attributes => [
                :actorsocial_id,
                :externo,
                :id,
                :rangoedadac_id,
                :perfilactorsocial_id,
                :_destroy,
                :persona_attributes => [
                  :apellidos, 
                  :id, 
                  :nombres, 
                  :numerodocumento, 
                  :sexo, 
                  :tdocumento_id,
                  :anionac,
                  :mesnac,
                  :dianac
                ]
              ],

              :respuestafor_attributes => [
                :id,
                "valorcampo_attributes" => [
                  :valor,
                  :campo_id,
                  :id 
                ] + 
                [:valor_ids => []]
              ],
              :proyecto_ids => [],
              :proyectofinanciero_ids => [],
              :usuario_ids => []
            ]
          end

          def lista_params
            lista_params_cor1440_gen
          end

          # Lista blanca de parametros
          def actividad_params
            params.require(:actividad).permit(lista_params)
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
            if @buscodigo && @buscodigo != '' then
              ac = ac.where(id: @buscodigo.to_i)
            end
            fi = param_escapa(par, 'fechaini')
            @fechaini = Date.strptime(fi, '%Y-%m-%d').to_s if fi && fi != ''
            if @fechaini && @fechaini != '' 
              ac = ac.where("fecha >= '#{@fechaini}'")
            end
            ff = param_escapa(par, 'fechafin')
            @fechafin = Date.strptime(ff, '%Y-%m-%d').to_s if ff && ff != ''
            if @fechafin && @fechafin != '' then
              ac = ac.where("fecha <= '#{@fechafin}'")
            end
            @busoficina = param_escapa(par, 'busoficina')
            if @busoficina && @busoficina != '' then
              ac = ac.where(oficina_id: @busoficina)
            end
            @busresponsable = param_escapa(par, 'busresponsable')
            if @busresponsable && @busresponsable != '' then
              ac = ac.where(responsable: @busresponsable)
            end
            @busnombre = param_escapa(par, 'busnombre')
            if @busnombre && @busnombre != '' then
              ac = ac.where("unaccent(nombre) ILIKE unaccent(?)", "%#{@busnombre}%")
            end
            @busarea = param_escapa(par, 'busarea')
            if @busarea && @busarea != '' then
              ac = ac.joins(:actividadareas_actividad).where(
                "cor1440_gen_actividadareas_actividad.actividadarea_id = ?",
                @busarea.to_i
              )
            end
            @busactividadpf= param_escapa(par, 'busactividadpf')
            if @buscatividadpf && @busactividadpf != '' then
              ac = ac.joins(:actividadpf).where(
                "cor1440_gen_actividadpf.id = ?",
                @busactividadpf.to_i
              )
            end
            @busobjetivo = param_escapa(par, 'busobjetivo')
            if @busobjetivo && @busobjetivo != '' then
              ac = ac.where("unaccent(objetivo) ILIKE unaccent(?)", "%#{@busobjetivo}%")
            end
            @busproyecto = param_escapa(par, 'busproyecto')
            if @busproyecto && @busproyecto != '' then
              ac = ac.joins(:actividad_proyecto).where(
                "cor1440_gen_actividad_proyecto.proyecto_id= ?",
                @busproyecto.to_i
              )
            end
            @busproyectofinanciero = param_escapa(par, 'busproyectofinanciero')
            if @busproyectofinanciero && @busproyectofinanciero != '' then
              ac = ac.joins(:proyectofinanciero).where(
                "cor1440_gen_proyectofinanciero.id= ?",
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


