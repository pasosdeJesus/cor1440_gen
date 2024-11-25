# frozen_string_literal: true

module Cor1440Gen
  module Concerns
    module Controllers
      module ProyectosfinancierosController
        extend ActiveSupport::Concern

        included do
          include Msip::FormatoFechaHelper
          helper Msip::FormatoFechaHelper

          def clase
            "Cor1440Gen::Proyectofinanciero"
          end

          def registrar_en_bitacora
            false
          end

          def new_modelo_path(o)
            new_proyectofinanciero_path
          end

          def set_proyectofinanciero
            @registro = Proyectofinanciero.find(params[:id])
          end

          def destroy_cor1440_gen
            authorize!(:destroy, @registro)
            pmindicadorespf = Cor1440Gen::Pmindicadorpf.where(
              mindicadorpf_id: @registro.mindicadorpf.ids,
            ).ids
            pmindicadorespf.each do |idpm|
              Cor1440Gen::DatointermediotiPmindicadorpf.where(
                pmindicadorpf_id: idpm,
              ).destroy_all
            end
          end

          # Redefinimos destroy porque el de tablas basicas
          # (i.e Msip::Admin::BasicasController que debe ser
          # papa de la clase que incluye a esta)
          # exije eliminar primero registros en tablas union
          def destroy
            destroy_cor1440_gen
            super("", false)
          end

          def atributos_index_cor1440
            [
              :id,
              :nombre,
              :titulo,
            ] +
              [financiador_ids: []] +
              [
                :fechainicio,
                :fechacierre,
                :responsable,
              ] +
              [proyecto_ids: []] +
              [
                :compromisos,
                :montoejp_localizado,
                :observaciones,
                :objetivopf,
                :indicadorobjetivo,
                :resultadopf,
                :indicadorpf,
                :actividadpf,
              ]
          end

          def atributos_index
            atributos_index_cor1440
          end

          def atributos_show
            [
              :id,
              :nombre,
              :titulo,
            ] +
              [financiador_ids: []] + [
                :sectorapc,
                :fechainicio_localizada,
                :fechacierre_localizada,
                :duracion,
                :anioformulacion,
                :mesformulacion,
                :fechaaprobacion_localizada,
                :fechaliquidacion_localizada,
                :estado,
                :dificultad,
                :responsable,
                :aprobadoobs,
                :proyectofinanciero_usuario,
              ] +
              [
                :tipomoneda,
                :tasaej,
                :montoejp_localizado,
                :desembolso,
                :informenarrativo,
                :informefinanciero,
                :informeauditoria,
                :marcologico,
                :anexo_proyectofinanciero,
                :observaciones,
                :caracterizacion,
                :beneficiario,
                :plantillahcm,
              ]
          end

          #          def atributos_form
          #          No usado porque el formulario es a mano

          def genclase
            "M"
          end

          def index(c = nil)
            c = Cor1440Gen::ProyectosfinancierosController.disponibles(
              params, current_ability, c
            )
            if c.count == 0 &&
                cannot?(:listado, Cor1440Gen::Proyectofinanciero) &&
                cannot?(:index, Cor1440Gen::Proyectofinanciero)
              flash[:error] = "No se puede acceder a #{clase}"
              redirect_to(main_app.root_path)
              return
            end
            super(c)
          end

          # API JSON, dado un conjunto de proyectosfinancieros
          # responde con las actividadespf de sus marcos lógicos
          def actividadespf
            authorize!(:read, Cor1440Gen::Proyectofinanciero)
            pfl = []
            if params[:pfl] && params[:pfl] != ""
              params[:pfl].each do |pf|
                pfl << pf.to_i
              end
            end
            c = Cor1440Gen::Actividadpf.where(proyectofinanciero_id: pfl)
            respond_to do |format|
              format.json do
                @registros = @registro = c.all
                render(:actividadespf) # , json: @registro
                return
              end
              format.js do
                @registros = @registro = c.all
                render(:actividadespf) # , json: @registro
              end
              format.html do
                render(
                  inline: @registros.errors,
                  status: :unprocessable_entity,
                )
              end
            end
          end

          # API JSON, dado un conjunto de proyectosfinancieros
          # responde con los objetivos de sus marcos lógicos
          def objetivospf
            authorize!(:read, Cor1440Gen::Proyectofinanciero)
            pfl = []
            if params[:pfl] && params[:pfl] != ""
              params[:pfl].each do |pf|
                pfl << pf.to_i
              end
            end
            c = Cor1440Gen::Objetivopf.where(proyectofinanciero_id: pfl)
            respond_to do |format|
              format.json do
                @registros = @registro = c.all
                render(:objetivospf)
                return
              end
              format.js do
                @registros = @registro = c.all
                render(:objetivospf)
              end
              format.html do
                render(
                  inline: @registros.errors,
                  status: :unprocessable_entity,
                )
              end
            end
          end

          def copia
            if !params || !params[:proyectofinanciero_id]
              render(inline: "Falta parámetro proyectofinanciero_id")
              return
            end
            if Cor1440Gen::Proyectofinanciero.where(
              id: params[:proyectofinanciero_id].to_i,
            ).count != 1
              render(inline: "No existe proyectofinanciero con el proyectofinanciero_id dado")
              return
            end
            p = Cor1440Gen::Proyectofinanciero.find(
              params[:proyectofinanciero_id].to_i,
            )
            authorize!(:create, Cor1440Gen::Proyectofinanciero)
            @registro = p.dup
            @registro.nombre += " " + Time.now.to_i.to_s
            unless @registro.save # Elegir otra id
              render(inline: "No pudo salvar copia sin campos")
              return
            end
            # no se copian actividades, ni beneficiarios, ni anexos, ni medición de
            # indicadores, ni plantillas de exportación/importación

            # copia caracterizaciones
            [
              ["Cor1440Gen::Caracterizacionpf", "caracterización"],
              ["Cor1440Gen::FinanciadorProyectofinanciero", "financiador"],
              ["Cor1440Gen::ProyectoProyectofinanciero", "proyecto"],
              ["Cor1440Gen::ProyectofinancieroUsuario", "usuario"],
            ].each do |par|
              par[0].constantize.where(proyectofinanciero_id: p.id)
                .each do |tr|
                ntr = tr.dup
                ntr.proyectofinanciero_id = @registro.id
                unless ntr.save
                  render(inline: "No pudo salvar copia de #{par[1]}")
                  return
                end
              end # tr
            end # par

            Cor1440Gen::Objetivopf.where(proyectofinanciero_id: p.id).each do |ob|
              nob = ob.dup
              nob.proyectofinanciero_id = @registro.id
              unless nob.save
                render(inline: "No pudo salvar copia de objetivo")
                return
              end
              Cor1440Gen::Indicadorpf.where(
                proyectofinanciero_id: p.id, objetivopf_id: ob.id,
              )
                .each do |ind|
                nind = ind.dup
                nind.proyectofinanciero_id = @registro.id
                nind.objetivopf_id = ob.id
                unless nind.save
                  render(inline: "No pudo salvar copia de indicador de efecto")
                  return
                end
              end # Indicadorpf
              Cor1440Gen::Resultadopf.where(
                proyectofinanciero_id: p.id, objetivopf_id: ob.id,
              )
                .each do |res|
                nres = res.dup
                nres.proyectofinanciero_id = @registro.id
                nres.objetivopf_id = nob.id
                unless nres.save
                  render(inline: "No pudo salvar copia de resultado")
                  return
                end
                Cor1440Gen::Indicadorpf.where(
                  proyectofinanciero_id: p.id, resultadopf_id: res.id,
                )
                  .each do |ind|
                  nind = ind.dup
                  nind.proyectofinanciero_id = @registro.id
                  nind.resultadopf_id = res.id
                  unless nind.save
                    render(inline: "No pudo salvar copia de indicador de resultado")
                    return
                  end
                end # Indicadorpf
                Cor1440Gen::Actividadpf.where(
                  proyectofinanciero_id: p.id, resultadopf_id: res.id,
                )
                  .each do |act|
                  nact = act.dup
                  nact.proyectofinanciero_id = @registro.id
                  nact.resultadopf_id = nres.id
                  unless nact.save
                    render(inline: "No pudo salvar copia de actividad")
                    return
                  end
                end # Actividadpf
              end # Resultadopf
            end # Objetivopf

            unless @registro.save # Elegir otra id
              render(inline: "No pudo salvar copia con campos")
              return
            end
            @registro_orig_id = p.id
            render(:copia, layout: "application")
          end

          # Validamos en controlador que no haya repetidos en equipo de trabajo
          #
          # No se logró hacer en modelo seguramente por coccoon
          # (cuando había un usuario del equipo de trabajo 2 veces
          # y se eliminaba el segundo, seguía presentando error de validación).
          def validaciones(registro)
            @validaciones_error = ""
            fus = []
            if params && params[:proyectofinanciero] && params[:proyectofinanciero][:proyectofinanciero_usuario_attributes]
              params[:proyectofinanciero][:proyectofinanciero_usuario_attributes].each do |_l, v|
                if v[:_destroy] != "true" && v[:_destroy] != "1"
                  if fus.include?(v[:usuario_id].to_i)
                    @validaciones_error << "El usuario "\
                      "#{::Usuario.find(v[:usuario_id].to_i).nusuario} "\
                      "está repetido en el equipo de trabajo"
                  else
                    fus << v[:usuario_id].to_i
                  end
                end
              end
            end
            @validaciones_error == ""
          end

          def new_cor1440_gen
            authorize!(:new, Cor1440Gen::Proyectofinanciero)
            @registro = clase.constantize.new
            @registro.monto = 1
            @registro.nombre = "N"
          end

          def new
            new_cor1440_gen
            @registro.save!
            redirect_to(cor1440_gen.edit_proyectofinanciero_path(@registro))
          end

          # Completa modificacion de validarpf y registro según filtro
          def validar_filtramas
          end

          def validar
            @validarpf = Cor1440Gen::Validarpf.new
            @registro = Cor1440Gen::Proyectofinanciero.all
            if params && params[:validarpf] &&
                params[:validarpf][:fechaini] &&
                params[:validarpf][:fechaini] != ""
              @validarpf.fechaini = params[:validarpf][:fechaini]
              @registro = @registro.where(
                "fechainicio >= ?",
                @validarpf.fechaini,
              )
            end
            if params && params[:validarpf] &&
                params[:validarpf][:fechafin] &&
                params[:validarpf][:fechafin] != ""
              @validarpf.fechafin = params[:validarpf][:fechafin]
              @registro = @registro.where(
                "fechainicio <= ?",
                @validarpf.fechafin,
              )
            end
            validar_filtramas

            render("validar", layout: "application")
          end

          # Más validaciones a un proyecto financiero
          # @param registro proyecto que se valida
          # @param detalle Lista de errores, se agregan si hay
          def validar_mas_registro(registro, detalle)
          end

          # Valida un proyecto financiero
          # @param registro proyecto que se valida
          # @param detalle Lista de errores, se agregan si hay
          def validar_registro(registro, detalle)
            detalleini = detalle.clone
            if !registro.fechainicio &&
                Cor1440Gen::ApplicationHelper::ESTADOS_APROBADO.include?(registro.estado)
              detalle << "No tiene fecha de inicio"
            elsif registro.fechainicio && registro.fechainicio < Date.new(2000, 1, 1)
              detalle << "Fecha de inicio anterior al 1.Ene.2000"
            end
            if !registro.fechacierre &&
                Cor1440Gen::ApplicationHelper::ESTADOS_APROBADO.include?(registro.estado)
              detalle << "No tiene fecha de terminación"
            elsif registro.fechacierre && registro.fechainicio &&
                registro.fechacierre <= registro.fechainicio
              detalle << "Fecha de terminación posterior o igual a la de inicio"
            end
            validar_mas_registro(registro, detalle)
            detalleini == detalle
          end

          def editar_intermedio(registro, usuario_actual_id)
            if registro.indicadorpf.where(resultadopf_id: nil)
                .where(objetivopf_id: nil).count > 0
              registro.indicadorpf.where(resultadopf_id: nil)
                .where(objetivopf_id: nil).destroy_all
            end
            if @registro.nombre == "N"
              @registro.nombre = ""
            end
            true
          end

          def vistas_manejadas
            ["Proyecto"]
          end

          # API calcduracion fechaini fechacierre
          # Retorna cadena con duracion
          def duracion
            prob = ""
            if params[:fechainicio] &&
                params[:fechacierre]
              fini = params[:fechainicio]
              fini = Date.strptime(fini, "%Y-%m-%d")
              fcierre = params[:fechacierre]
              fcierre = Date.strptime(fcierre, "%Y-%m-%d")
              if fini && fcierre
                d = Msip::FormatoFechaHelper.dif_meses_dias(fini, fcierre)
                respond_to do |format|
                  format.json do
                    render(json: { duracion: d.to_s }, status: :ok)
                    return
                  end
                end
              else
                prob = "No pudo convertirse una de las fechas"
              end
            else
              prob = "Indispensables parametros fechaini y fechacierre"
            end
            respond_to do |format|
              format.html { render(action: "error") }
              format.json do
                render(
                  json: prob,
                  status: :unprocessable_entity,
                )
              end
            end
          end

          def proyectofinanciero_params_cor1440_gen
            [
              :id,
              :nombre,
              :titulo,
            ] +
              [financiador_ids: []] + [
                :sectorapc,
                :fechainicio,
                :fechacierre,
                :duracion,
                :anioformulacion,
                :mesformulacion,
                :fechaaprobacion,
                :fechaliquidacion,
                :estado,
                :dificultad,
                :responsable,
                :aprobadoobs,
                :proyectofinanciero_usuario,
                :tipomoneda,
                :tasaej,
                :desembolso,
                :informenarrativo,
                :informefinanciero,
                :informeauditoria,
                :marcologico,
                :anexo_proyectofinanciero,
                :observaciones,
                :caracterizacion,
                :beneficiario,
                :plantillahcm,

                :centrocosto,
                :estado,
                :dificultad,
                :fechaaprobacion,
                :fechacierre,
                :fechaformulacion,
                :fechaformulacion_anio,
                :fechaformulacion_mes,
                :fechaliquidacion,
                :tasaej_localizado,
                :montoej_localizado,
                :aportepropioej_localizado,
                :aporteotrosej_localizado,
                :presupuestototalej_localizado,
                :responsable_id,
                :saldoaejecutarp_localizado,
                :sectorapc_id,
                :tipomoneda_id,
              ] + [
                actividadpf_attributes: [
                  :actividadtipo_id,
                  :descripcion,
                  :formulario_id,
                  :heredade_id,
                  :id,
                  :nombrecorto,
                  :resultadopf_id,
                  :titulo,
                  :_destroy,
                ],
              ] + [
                anexo_proyectofinanciero_attributes: [
                  :id,
                  :proyectofinanciero_id,
                  :_destroy,
                  anexo_attributes: [
                    :adjunto,
                    :descripcion,
                    :id,
                    :_destroy,
                  ],
                ],
              ] + [
                beneficiario_ids: [],
              ] + [
                caracterizacion_ids: [],
              ] + [
                desembolso_attributes: [
                  :id,
                  :detalle,
                  :fecha,
                  :valorpesos_localizado,
                  :_destroy,
                ],
              ] + [
                indicadorobjetivo_attributes: [
                  :id,
                  :objetivopf_id,
                  :numero,
                  :indicador,
                  :tipoindicador_id,
                  :_destroy,
                ],
              ] + [
                indicadorpf_attributes: [
                  :id,
                  :objetivopf_id,
                  :resultadopf_id,
                  :numero,
                  :indicador,
                  :_destroy,
                ],
              ] + [
                informeauditoria_attributes: [
                  :detalle,
                  :fecha,
                  :devoluciones,
                  :seguimiento,
                  :id,
                  :_destroy,
                ],
              ] + [
                informefinanciero_attributes: [
                  :detalle,
                  :fecha,
                  :devoluciones,
                  :seguimiento,
                  :id,
                  :_destroy,
                ],
              ] + [
                informenarrativo_attributes: [
                  :detalle,
                  :fecha,
                  :devoluciones,
                  :seguimiento,
                  :id,
                  :_destroy,
                ],
              ] + [
                objetivopf_attributes: [
                  :id,
                  :numero,
                  :objetivo,
                  :_destroy,
                ],
              ] + [
                plantillahcm_ids: [],
              ] + [
                proyectofinanciero_usuario_attributes: [
                  :id,
                  :usuario_id,
                  :_destroy,
                ],
              ] + [
                resultadopf_attributes: [
                  :id,
                  :objetivopf_id,
                  :numero,
                  :resultado,
                  :_destroy,
                ],
              ]
          end

          def proyectofinanciero_params
            params.require(:proyectofinanciero).permit(
              proyectofinanciero_params_cor1440_gen,
            )
          end
        end # included

        class_methods do
          # Retorna ids de proyectos que el usuario actual puede leer de
          # acuerdo a control de acceso definido con cancancan y con
          # las restricciones del filtro:
          #   filtro[:fecha] limita a proyectos vigentes en la fecha
          # Usado en formulario actividad en lista de selección de proyectos
          # y en índice de proyectos
          def disponibles_cor1440_gen(filtro, ability, c = nil)
            if c.nil?
              c = Cor1440Gen::Proyectofinanciero
            end
            c2 = c.accessible_by(ability)
            if filtro[:fecha] && filtro[:fecha] != ""
              menserror = ""
              nfr = Msip::FormatoFechaHelper.reconoce_adivinando_locale(
                filtro[:fecha], menserror
              )
              if menserror != ""
                puts "** Problema con fecha '#{filtro[:fecha]}'. #{menserror}"
              else
                c2 = c2.where(
                  "(fechainicio <= ? OR fechainicio IS NULL) AND " +
                  "(? <= fechacierre OR fechacierre IS NULL)",
                  nfr.to_s,
                  nfr.to_s,
                )
              end
            end
            c2
          end

          def disponibles(filtro, ability, c = nil)
            disponibles_cor1440_gen(filtro, ability, c)
          end
        end # class_methods
      end
    end
  end
end
