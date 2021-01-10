module Cor1440Gen
  module Concerns
    module Controllers
      module ActividadesController
        extend ActiveSupport::Concern

        included do

          def clase
            "Cor1440Gen::Actividad"
          end

          def genclase
            return 'F'
          end

          def atributos_index
            [ :id, 
              :fecha_localizada, 
              :nombre, 
              :responsable,
              :proyectofinanciero,
              :actividadpf, 
              :objetivo,
              :poblacion,
              :anexos
            ]
          end

          def atributos_form
            atributos_show - [:id, :actividadpf]
          end

          def atributos_show
            [ :id, 
              :fecha_localizada, 
              :nombre, 
              :lugar, 
              :responsable,
              :corresponsables,
              :proyectofinanciero, 
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

          def vistas_manejadas
            ['Actividad']
          end

          def index_reordenar(c)
            c = c.reorder('cor1440_gen_actividad.fecha DESC')
            return c
          end

          def new_cor1440_gen
            @registro = @actividad = Actividad.new
            @registro.current_usuario = current_usuario
            @registro.oficina_id = current_usuario && 
              current_usuario.oficina_id ? current_usuario.oficina_id : 1
            @registro.fecha = Date.today
            @registro.usuario_id= current_usuario.id
            @registro.save!(validate: false)
            return @registro
          end

          # GET /actividades/new
          def new
            new_cor1440_gen
            redirect_to cor1440_gen.edit_actividad_path(@registro)
          end

          def destroy
            pf_act = Cor1440Gen::ActividadProyectofinanciero.
              where(actividad_id: @registro.id)
            if pf_act.count > 0
              pf_act[0].destroy!
            end
            destroy_gen
            #@registro.destroy!
            #redirect_to cor1440_gen.actividades_path
          end

          def asegura_camposdinamicos(actividad, current_usuario_id)
            @listadoasistencia = false
            vfid = []  # ids de formularios que deben presentarse
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
                    r = aw.take
                    ar = Cor1440Gen::ActividadRespuestafor.where(
                      actividad_id: actividad.id,
                      respuestafor_id: r.id,
                    ).take
                  end
                  Mr519Gen::ApplicationHelper::asegura_camposdinamicos(
                    ar, current_usuario_id)
                end
              end
            end
            if vfid.count > 0
              ar = Cor1440Gen::ActividadRespuestafor.
                where(actividad_id: actividad.id).
                joins(:respuestafor).
                where("formulario_id NOT IN (#{vfid.join(', ')})")
            else #vfid.count == 0
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
            if cannot? :edit, clase.constantize
              authorize! :update, @registro
            end
            if params['actividadpf_ids']
              @registro.actividadpf_ids = params['actividadpf_ids']
            end
            asegura_camposdinamicos(@registro, current_usuario.id)
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


          # Filtra actividades por contar @contar_actividad,
          # proyectos financieros por presentar @contar_pf y
          # proyecto por omision @contar_pfid
          # de acuerdo al control de acceso
          def filtra_contar_control_acceso

          end

          # Filtra actividades por contar @contar_actividad,
          # proyectos financieros por presentar @contar_pf 
          # proyecto por omision @contar_pfid
          # de acuerdo a parámetros (fuera de los estándar fechaini, 
          # fechafin y pfid)
          def filtra_contar_por_parametros

          end

          # Genera conteo por actividad de convenio
          def contar
            @contar_actividad = Cor1440Gen::Actividad.all
            @contar_pf = Cor1440Gen::Proyectofinanciero.all
            @contar_pfid = nil
            @contar_ofi = nil

            # Control de acceso
            filtra_contar_control_acceso

            # Parámetros
            @contar_pfid = params[:filtro] && 
              params[:filtro][:proyectofinanciero_id] ?  
              params[:filtro][:proyectofinanciero_id].to_i : @contar_pfid

            @contar_ofi = params[:filtro] &&
              params[:filtro][:oficina_id] ?
              params[:filtro][:oficina_id].to_i : @contar_ofi

            if !params[:filtro] || !params[:filtro]['fechaini'] || 
                params[:filtro]['fechaini'] != ""
              if !params[:filtro] || !params[:filtro]['fechaini']
                @fechaini = Sip::FormatoFechaHelper.inicio_semestre_ant
              else
                @fechaini = Sip::FormatoFechaHelper.fecha_local_estandar(params[:filtro]['fechaini'])
              end
              @contar_actividad = @contar_actividad.where(
                'cor1440_gen_actividad.fecha >= ?', @fechaini)
            end

            if !params[:filtro] || !params[:filtro]['fechafin'] || 
                params[:filtro]['fechafin'] != ""
              if !params[:filtro] || !params[:filtro]['fechafin']
                @fechafin = Sip::FormatoFechaHelper.fin_semestre_ant
              else
                @fechafin = Sip::FormatoFechaHelper.fecha_local_estandar(params[:filtro]['fechafin'])
              end
              @contar_actividad = @contar_actividad.where(
                'cor1440_gen_actividad.fecha <= ?', @fechafin)
            end

            if params[:filtro] && params[:filtro]['oficina_id'] && 
                params[:filtro]['oficina_id'] != ''
              @contar_actividad = @contar_actividad.where(
                'cor1440_gen_actividad.oficina_id = ?', @contar_ofi)
            end
            filtra_contar_por_parametros 

            respond_to do |format|
              format.html { render layout: 'application' }
              format.json { head :no_content }
              format.js { render }
            end
          end

          # Por sobrecargar
          def filtra_contarb_actividad_por_parametros(contarb_actividad)
            contarb_actividad
          end

          def ini_asistencia_ram(lids)
            "SELECT sub2.* FROM (SELECT sub.*, 
               (SELECT nombre FROM cor1440_gen_rangoedadac AS red
                WHERE id=CASE 
                  WHEN (red.limiteinferior IS NULL OR 
                    red.limiteinferior<=sub.edad_en_actividad) AND 
                    (red.limitesuperior IS NULL OR
                    red.limitesuperior>=sub.edad_en_actividad) THEN
                    red.id
                  ELSE
                    7 -- SIN INFORMACION
                END LIMIT 1) AS rangoedadac_nombre,
               (SELECT id FROM cor1440_gen_rangoedadac AS red
                WHERE id=CASE 
                  WHEN (red.limiteinferior IS NULL OR 
                    red.limiteinferior<=sub.edad_en_actividad) AND 
                    (red.limitesuperior IS NULL OR
                    red.limitesuperior>=sub.edad_en_actividad) THEN
                    red.id
                  ELSE
                    7 -- SIN INFORMACION
                END LIMIT 1) AS rangoedadac_id
            FROM (SELECT asis.id,
              asis.persona_id,
              TRIM(TRIM(p.nombres) || ' '  ||
                TRIM(p.apellidos)) AS persona_nombre,
              TRIM(COALESCE(td.sigla || ':', '') ||
                COALESCE(p.numerodocumento, '')) AS persona_identificacion,
              public.sip_edad_de_fechanac_fecharef(
                p.anionac, p.mesnac, p.dianac,
              EXTRACT(YEAR FROM a.fecha)::integer,
              EXTRACT(MONTH from a.fecha)::integer,
              EXTRACT(DAY FROM a.fecha)::integer) AS edad_en_actividad,
              p.sexo AS persona_sexo,
              a.id AS actividad_id,
              a.fecha as actividad_fecha,
              apf.id AS actividadpf_id,
              pf.id AS proyectofinanciero_id
            FROM cor1440_gen_asistencia AS asis
            JOIN sip_persona AS p ON p.id=asis.persona_id
            LEFT JOIN sip_tdocumento AS td ON td.id=p.tdocumento_id
            JOIN cor1440_gen_actividad AS a ON asis.actividad_id=a.id
            JOIN cor1440_gen_actividad_actividadpf AS acapf 
              ON  acapf.actividad_id=a.id
            JOIN cor1440_gen_actividadpf AS apf ON apf.id=acapf.actividadpf_id
            JOIN cor1440_gen_proyectofinanciero AS pf 
              ON apf.proyectofinanciero_id=pf.id
            WHERE a.id IN (#{lids})) AS sub) as sub2 WHERE true=true
            "
          end


          # Genera conteo por beneficiario y actividad de convenio
          def contar_beneficiarios
            @contarb_actividad = Cor1440Gen::Actividad.all
            @contarb_pf = Cor1440Gen::Proyectofinanciero.all
            @contarb_pfid = nil

            # Control de acceso
            #filtra_contarb_control_acceso

            # Parámetros
            @contarb_pfid = params[:filtro] && 
              params[:filtro][:proyectofinanciero_id] ?  
              params[:filtro][:proyectofinanciero_id].to_i : @contarb_pfid

            @contarb_actividad = @contarb_actividad.where(
              'cor1440_gen_actividad.id IN 
                (SELECT actividad_id FROM cor1440_gen_actividad_proyectofinanciero
                  WHERE proyectofinanciero_id=?)',@contarb_pfid).where(
                    'cor1440_gen_actividad.id IN 
                (SELECT actividad_id FROM cor1440_gen_actividad_actividadpf)')

            if !params[:filtro] || !params[:filtro]['fechaini'] || 
                params[:filtro]['fechaini'] != ""
              if !params[:filtro] || !params[:filtro]['fechaini']
                @contarb_fechaini = Sip::FormatoFechaHelper.inicio_semestre_ant
              else
                @contarb_fechaini = Sip::FormatoFechaHelper.fecha_local_estandar(
                  params[:filtro]['fechaini'])
              end
              @contarb_actividad = @contarb_actividad.where(
                'cor1440_gen_actividad.fecha >= ?', @contarb_fechaini)
            end

            if !params[:filtro] || !params[:filtro]['fechafin'] || 
                params[:filtro]['fechafin'] != ""
              if !params[:filtro] || !params[:filtro]['fechafin']
                @contarb_fechafin = Sip::FormatoFechaHelper.fin_semestre_ant
              else
                @contarb_fechafin = Sip::FormatoFechaHelper.fecha_local_estandar(
                  params[:filtro]['fechafin'])
              end
              @contarb_actividad = @contarb_actividad.where(
                'cor1440_gen_actividad.fecha <= ?', @contarb_fechafin)
            end

            @contarb_actividad = filtra_contarb_actividad_por_parametros(
              @contarb_actividad)

            @contarb_listaac = Cor1440Gen::Actividadpf.where(
              proyectofinanciero_id: @contarb_pfid).order(:nombrecorto) 

            mas_where_asistencia_ram = ''
            if params[:filtro] && params[:filtro]['buspersona_id'] &&
                params[:filtro]['buspersona_id'] != ""
              mas_where_asistencia_ram += " AND " +
                "persona_id = #{params[:filtro]['buspersona_id'].to_i}"
            end
            if params[:filtro] && params[:filtro]['bussexo'] &&
                params[:filtro]['bussexo'] != "" &&
                Sip::EdadSexoHelper::SEXO_OPCIONES.map(&:last).include?(
                  params[:filtro]['bussexo'])
              mas_where_asistencia_ram += " AND " +
                "persona_sexo = '#{params[:filtro]['bussexo']}'"
            end
            if params[:filtro] && params[:filtro]['busrangoedadac_id'] &&
                params[:filtro]['busrangoedadac_id'] != ""
              mas_where_asistencia_ram += " AND " +
                "rangoedadac_id = '#{params[:filtro]['busrangoedadac_id']}'"
            end

            lids = @contarb_actividad.count> 0 ?
              @contarb_actividad.pluck(:id).join(",") : "0"
            @contarb_asistencia_ram = Cor1440Gen::Asistencia.connection.
              execute <<-SQL
              #{ini_asistencia_ram(lids)}
              #{mas_where_asistencia_ram}
            SQL

            respond_to do |format|
              format.html { render layout: 'application' }
              format.json { head :no_content }
              format.js { render }
            end
          end


          def relacionadas
            prob = ''
            actividadpf_ids = []
            proyectofinanciero_ids = []
            if params[:proyectofinanciero_ids]
              proyectofinanciero_ids = params[:proyectofinanciero_ids]
            end
            if params[:actividadpf_ids]
              params[:actividadpf_ids].reject(&:empty?).each do |ac|
                if Cor1440Gen::Actividadpf.where(id: ac)
                  tipo = Cor1440Gen::Actividadpf.
                    find(ac).actividadtipo_id
                  if !tipo.nil?
                    presente_otros = Cor1440Gen::Actividadpf.
                      where(actividadtipo_id: tipo).
                      where(proyectofinanciero_id: proyectofinanciero_ids)
                    actividadpf_ids |= presente_otros.pluck(:id).uniq
                  end
                end
              end
              respond_to do |format|
                format.json { 
                  render json: {
                    ac_ids_relacionadas: actividadpf_ids}, 
                    status: :ok
                    return
                }
              end
            else
              prob = 'Falla al convertir parametros'
            end
            respond_to do |format|
              format.html { render action: "error" }
              format.json { render json: prob, 
                            status: :unprocessable_entity 
              }
            end
          end

          private

          def set_actividad
            @registro = nil
            if params[:id] && params[:id].to_i > 0
              @registro = @actividad = Actividad.find(params[:id].to_i)
              @actividad.current_usuario = current_usuario
            end
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
              :actividad_proyectofinanciero_attributes => [
                :id, :proyectofinanciero_id, :_destroy,
                :actividadpf_ids => []
              ],
              :actividad_rangoedadac_attributes => [
                :id, :rangoedadac_id, :fl, :fr, :ml, :mr, :s, :_destroy 
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
              :proyectofinanciero_attributes => [

              ],
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
#          def param_escapa(par, p)
#            par.nil? ? '' :
#              par[p] ? Sip::Pais.connection.quote_string(par[p].to_s) : 
#              par[p.to_sym] ? Sip::Pais.connection.quote_string(par[p.to_sym].to_s) :
#              par[p.to_s] ? Sip::Pais.connection.quote_string(par[p.to_s].to_s) :  ''
#          end
#
#          def filtra(par, current_usuario = nil)
#            ac = Actividad.order(fecha: :desc)
#            @buscodigo = param_escapa(par, 'buscodigo')
#            if @buscodigo && @buscodigo != '' then
#              ac = ac.where(id: @buscodigo.to_i)
#            end
#            fi = param_escapa(par, 'fechaini')
#            @fechaini = Date.strptime(fi, '%Y-%m-%d').to_s if fi && fi != ''
#            if @fechaini && @fechaini != '' 
#              ac = ac.where("fecha >= '#{@fechaini}'")
#            end
#            ff = param_escapa(par, 'fechafin')
#            @fechafin = Date.strptime(ff, '%Y-%m-%d').to_s if ff && ff != ''
#            if @fechafin && @fechafin != '' then
#              ac = ac.where("fecha <= '#{@fechafin}'")
#            end
#            @busoficina = param_escapa(par, 'busoficina')
#            if @busoficina && @busoficina != '' then
#              ac = ac.where(oficina_id: @busoficina)
#            end
#            @busresponsable = param_escapa(par, 'busresponsable')
#            if @busresponsable && @busresponsable != '' then
#              ac = ac.where(responsable: @busresponsable)
#            end
#            @busnombre = param_escapa(par, 'busnombre')
#            if @busnombre && @busnombre != '' then
#              ac = ac.where("unaccent(nombre) ILIKE unaccent(?)", "%#{@busnombre}%")
#            end
#            @busarea = param_escapa(par, 'busarea')
#            if @busarea && @busarea != '' then
#              ac = ac.joins(:actividadareas_actividad).where(
#                "cor1440_gen_actividadareas_actividad.actividadarea_id = ?",
#                @busarea.to_i
#              )
#            end
#            @busactividadpf= param_escapa(par, 'busactividadpf')
#            if @buscatividadpf && @busactividadpf != '' then
#              ac = ac.joins(:actividadpf).where(
#                "cor1440_gen_actividadpf.id = ?",
#                @busactividadpf.to_i
#              )
#            end
#            @busobjetivo = param_escapa(par, 'busobjetivo')
#            if @busobjetivo && @busobjetivo != '' then
#              ac = ac.where("unaccent(objetivo) ILIKE unaccent(?)", "%#{@busobjetivo}%")
#            end
#            @busproyecto = param_escapa(par, 'busproyecto')
#            if @busproyecto && @busproyecto != '' then
#              ac = ac.joins(:actividad_proyecto).where(
#                "cor1440_gen_actividad_proyecto.proyecto_id= ?",
#                @busproyecto.to_i
#              )
#            end
#            @busproyectofinanciero = param_escapa(par, 'busproyectofinanciero')
#            if @busproyectofinanciero && @busproyectofinanciero != '' then
#              ac = ac.joins(:proyectofinanciero).where(
#                "cor1440_gen_proyectofinanciero.id= ?",
#                @busproyectofinanciero.to_i
#              )
#            end
#            ac = filtramas(par, ac, current_usuario)
#            return ac
#          end

        end

      end
    end
  end
end


