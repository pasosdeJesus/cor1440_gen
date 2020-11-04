# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Controllers
      module ProyectosfinancierosController
        extend ActiveSupport::Concern

        included do
          include Sip::FormatoFechaHelper
          helper Sip::FormatoFechaHelper

          #load_and_authorize_resource  class: Cor1440Gen::Proyectofinanciero,
          #  only: [:new, :create, :destroy, :edit, :update, :index, :show,
          #         :objetivospf]
          before_action :set_proyectofinanciero,
            only: [:show, :edit, :update, :destroy]      
          skip_before_action :set_proyectofinanciero, only: [:validar]

          def clase 
            "Cor1440Gen::Proyectofinanciero"
          end

          def new_modelo_path(o)
            return new_proyectofinanciero_path()
          end

          def set_proyectofinanciero
            @registro = Proyectofinanciero.find(params[:id])
          end

          # Redefinimos destroy porque el de tablas basicas 
          # (i.e Sip::Admin::BasicasController que debe ser
          # papa de la clase que incluye a esta)
          # exije eliminar primero registros en tablas union
          def destroy
            authorize! :destroy, @registro
            pmindicadorespf = Cor1440Gen::Pmindicadorpf.where(
              mindicadorpf_id: @registro.mindicadorpf.ids).ids
            pmindicadorespf.each do |idpm|
              Cor1440Gen::DatointermediotiPmindicadorpf.where(
                pmindicadorpf_id: idpm).destroy_all
            end
            super("", false)
          end

          def atributos_index
            [ 
              :id, 
              :nombre 
            ] +
            [ :financiador_ids =>  [] ] +
            [ 
              :fechainicio_localizada,
              :fechacierre_localizada,
              :responsable,
              :proyectofinanciero_usuario,
            ] +
            [ :proyecto_ids =>  [] ] +
            [ :compromisos, 
              :monto, 
              :observaciones, 
              :objetivopf,
              :indicadorobjetivo,
              :resultadopf,
              :indicadorpf,
              :actividadpf
            ]
          end

          def atributos_form
            atributos_index +
              [
                :caracterizacion, 
                :beneficiario, 
                :plantillahcm, 
                :anexo_proyectofinanciero
            ] - [
              "id", :id, 'created_at', :created_at, 'updated_at', :updated_at
            ]
          end

          def atributos_show
            [ 
              :id, 
              :nombre 
            ] +
            [ :financiador_ids =>  [] ] +
            [ 
              :fechainicio_localizada,
              :fechacierre_localizada,
              :responsable,
              :proyectofinanciero_usuario,
            ] +
            [ :proyecto_ids =>  [] ] +
            [ :compromisos, 
              :monto, 
              :observaciones, 
              :marcologico,
              :caracterizacion, 
              :beneficiario,
              :plantillahcm,
              :anexo_proyectofinanciero
            ]
          end

          # Genero del nombre (F - Femenino, M - Masculino)
          def genclase
            return 'M';
          end

          def index(c = nil)
            authorize! :read, Cor1440Gen::Proyectofinanciero
            if c == nil
              c = Cor1440Gen::Proyectofinanciero.all
            end
            if params[:fecha] && params[:fecha] != ''
              fecha = fecha_local_estandar params[:fecha]
              c = c.where('fechainicio <= ? AND ' +
                          '(? <= fechacierre OR fechacierre IS NULL) ', 
                          fecha, fecha)
            end
            super(c)
          end  

          # API JSON, dado un conjunto de proyectosfinancieros
          # responde con las actividadespf de sus marcos lógicos
          def actividadespf
            authorize! :read, Cor1440Gen::Proyectofinanciero
            pfl = []
            if params[:pfl] && params[:pfl] != ''
              params[:pfl].each do |pf|
                pfl << pf.to_i
              end
            end
            c = Cor1440Gen::Actividadpf.where(proyectofinanciero_id: pfl)
            respond_to do |format|
              format.json {
                @registros = @registro = c.all
                render :actividadespf#, json: @registro
                return
              }
              format.js {
                @registros = @registro = c.all
                render :actividadespf#, json: @registro
              }
              format.html {
                render inline: @registros.errors, 
                status: :unprocessable_entity
              }
            end
          end

          # API JSON, dado un conjunto de proyectosfinancieros
          # responde con los objetivos de sus marcos lógicos
          def objetivospf
            authorize! :read, Cor1440Gen::Proyectofinanciero
            pfl = []
            if params[:pfl] && params[:pfl] != ''
              params[:pfl].each do |pf|
                pfl << pf.to_i
              end
            end
            c = Cor1440Gen::Objetivopf.where(proyectofinanciero_id: pfl)
            respond_to do |format|
              format.json {
                @registros = @registro = c.all
                render :objetivospf
                return
              }
              format.js {
                @registros = @registro = c.all
                render :objetivospf
              }
              format.html {
                render inline: @registros.errors, 
                status: :unprocessable_entity
              }
            end
          end


          def copia
            if !params || !params[:proyectofinanciero_id] 
              render inline: 'Falta parámetro proyectofinanciero_id'
              return
            end
            if Cor1440Gen::Proyectofinanciero.where(
                id: params[:proyectofinanciero_id].to_i).count != 1
              render inline: 'No existe proyectofinanciero con el proyectofinanciero_id dado'
              return
            end
            p = Cor1440Gen::Proyectofinanciero.find(
              params[:proyectofinanciero_id].to_i)
            authorize! :create, Cor1440Gen::Proyectofinanciero
            @registro = p.dup
            @registro.nombre += ' ' + Time.now.to_i.to_s
            if !@registro.save  # Elegir otra id
              render inline: 'No pudo salvar copia sin campos'
              return
            end
            # no se copian actividades, ni beneficiarios, ni anexos, ni medición de
            # indicadores, ni plantillas de exportación/importación

            # copia caracterizaciones
            [['Cor1440Gen::Caracterizacionpf', 'caracterización'],
             ['Cor1440Gen::FinanciadorProyectofinanciero', 'financiador'],
             ['Cor1440Gen::ProyectoProyectofinanciero', 'proyecto'],
             ['Cor1440Gen::ProyectofinancieroUsuario', 'usuario']
            ].each do |par|
              par[0].constantize.where(proyectofinanciero_id: p.id).
                each do |tr|
                ntr= tr.dup
                ntr.proyectofinanciero_id = @registro.id
                if !ntr.save
                  render inline: "No pudo salvar copia de #{par[1]}"
                  return
                end
              end #tr
            end #par

            Cor1440Gen::Objetivopf.where(proyectofinanciero_id: p.id).each do |ob|
              nob = ob.dup
              nob.proyectofinanciero_id = @registro.id
              if !nob.save
                render inline: "No pudo salvar copia de objetivo"
                return
              end
              Cor1440Gen::Indicadorpf.where(
                proyectofinanciero_id: p.id, objetivopf_id: ob.id).
                each do |ind|
                nind = ind.dup
                nind.proyectofinanciero_id = @registro.id
                nind.objetivopf_id = ob.id
                if !nind.save
                  render inline: "No pudo salvar copia de indicador de efecto"
                  return
                end
              end # Indicadorpf
              Cor1440Gen::Resultadopf.where(
                proyectofinanciero_id: p.id, objetivopf_id: ob.id).
                each do |res|
                nres = res.dup
                nres.proyectofinanciero_id = @registro.id
                nres.objetivopf_id = nob.id
                if !nres.save
                  render inline: "No pudo salvar copia de resultado"
                  return
                end
                Cor1440Gen::Indicadorpf.where(
                  proyectofinanciero_id: p.id, resultadopf_id: res.id).
                  each do |ind|
                  nind = ind.dup
                  nind.proyectofinanciero_id = @registro.id
                  nind.resultadopf_id = res.id
                  if !nind.save
                    render inline: "No pudo salvar copia de indicador de resultado"
                    return
                  end
                end # Indicadorpf
                Cor1440Gen::Actividadpf.where(
                  proyectofinanciero_id: p.id, resultadopf_id: res.id).
                  each do |act|
                  nact = act.dup
                  nact.proyectofinanciero_id = @registro.id
                  nact.resultadopf_id = nres.id
                  if !nact.save
                    render inline: "No pudo salvar copia de actividad"
                    return
                  end
                end # Actividadpf
              end  # Resultadopf
            end # Objetivopf

            if !@registro.save  # Elegir otra id
              render inline: 'No pudo salvar copia con campos'
              return
            end
            @registro_orig_id=p.id
            render :copia, layout: 'application'
          end

          def new
            authorize! :new, Cor1440Gen::Proyectofinanciero
            @registro = clase.constantize.new
            @registro.monto = 1
            @registro.nombre = 'N'
            @registro.save!
            redirect_to cor1440_gen.edit_proyectofinanciero_path(@registro)
          end

          # Completa modificacion de validarpf y registro según filtro
          def validar_filtramas
          end

          def validar
            @validarpf = Cor1440Gen::Validarpf.new
            @registro = Cor1440Gen::Proyectofinanciero.all
            if params && params[:validarpf] && 
              params[:validarpf][:fechaini_localizada] &&
              params[:validarpf][:fechaini_localizada] != ''
              @validarpf.fechaini_localizada = 
                params[:validarpf][:fechaini_localizada]
              @registro = @registro.where('fechainicio >= ?', 
                                          @validarpf.fechaini)
            end
            if params && params[:validarpf] && 
              params[:validarpf][:fechafin_localizada] &&
              params[:validarpf][:fechafin_localizada] != ''
              @validarpf.fechafin_localizada = 
                params[:validarpf][:fechafin_localizada]
              @registro = @registro.where('fechainicio <= ?', 
                                          @validarpf.fechafin)
            end
            validar_filtramas

            render 'validar', layout: 'application'
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
            if !registro.fechainicio 
              detalle << "No tiene fecha de inicio"
            elsif registro.fechainicio < Date.new(2000, 1, 1)
              detalle << "Fecha de inicio anterior al 1.Ene.2000"
            end
            if !registro.fechacierre
              detalle << "No tiene fecha de terminación"
            elsif registro.fechacierre <= registro.fechainicio
              detalle << "Fecha de terminación posterior o igual a la de inicio"
            end
            validar_mas_registro(registro, detalle)
            return detalleini == detalle
          end

          def editar_intermedio(registro, usuario_actual_id)
            if registro.indicadorpf.where(resultadopf_id: nil).
                where(objetivopf_id: nil)
              registro.indicadorpf.where(resultadopf_id: nil).
                where(objetivopf_id: nil).destroy_all
            end
          end

          def vistas_manejadas
            ['Proyecto']
          end

          def proyectofinanciero_params_cor1440_gen
            atributos_form + [:responsable_id] + [ 
              :actividadpf_attributes =>  [
                :id, 
                :resultadopf_id,
                :actividadtipo_id,
                :nombrecorto, 
                :titulo, 
                :descripcion, 
                :_destroy ] 
            ] + [
              :anexo_proyectofinanciero_attributes => [
                :id,
                :proyectofinanciero_id,
                :_destroy,
                :anexo_attributes => [
                  :adjunto, 
                  :descripcion, 
                  :id, 
                  :_destroy ] ]
            ] + [
              :beneficiario_ids => []
            ] + [
              :caracterizacion_ids => []
            ] + [
              :plantillahcm_ids => []
            ] + [
              :indicadorobjetivo_attributes =>  [
                :id, 
                :objetivopf_id,
                :numero, 
                :indicador, 
                :tipoindicador_id, 
                :_destroy ] 
            ] + [ 
              :indicadorpf_attributes =>  [
                :id, 
                :resultadopf_id,
                :numero, 
                :indicador, 
                :tipoindicador_id,
                :_destroy ] 
            ] + [ 
              :objetivopf_attributes =>  [
                :id, 
                :numero, 
                :objetivo, 
                :_destroy ] 
            ] + [
              :proyectofinanciero_usuario_attributes => [
                :id,
                :usuario_id,
                :_destroy ]
            ] + [
              :resultadopf_attributes =>  [
                :id, 
                :objetivopf_id,
                :numero, 
                :resultado, 
                :_destroy ] 
            ]
          end

          def proyectofinanciero_params
            params.require(:proyectofinanciero).permit(
              proyectofinanciero_params_cor1440_gen)
          end



        end # included

      end
    end
  end
end

