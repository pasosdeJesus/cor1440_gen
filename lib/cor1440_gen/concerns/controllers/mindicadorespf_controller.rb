# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Controllers
      module MindicadorespfController 
        extend ActiveSupport::Concern

        included do

          before_action :set_mindicadorpf, 
            only: [:show, :edit, :update, :destroy]
          load_and_authorize_resource class: Cor1440Gen::Mindicadorpf

          def clase
            "Cor1440Gen::Mindicadorpf"
          end

          def atributos_index
            [ "id",
              #"proyectofinanciero_id",
              "indicadorpf_id",
              "frecuenciaanual",
              "pmindicador"
            ]
          end

          def atributos_form
            [ "proyectofinanciero_id",
              "indicadorpf_id"] +
              (@registro && @registro.indicadorpf && 
               @registro.indicadorpf.resultadopf ? [:actividadpf] : []) +
            [
              "frecuenciaanual",
              "pmindicador"
            ]
          end


          def index_reordenar(registros)
            @contar_pf = Cor1440Gen::Proyectofinanciero.all
            @contar_pfid = params[:filtro] && 
              params[:filtro][:busproyectofinanciero_id] ?  
              params[:filtro][:busproyectofinanciero_id].to_i : (@contar_pfid or nil)

            return registros.where(proyectofinanciero_id: @contar_pfid).
              reorder(proyectofinanciero_id: :asc, indicadorpf_id: :asc)
          end

          def new_modelo_path(o)
            return new_minidicadorpf_path()
          end


          # Retorna listado de ids diferentes de 
          #   actividades con actividadpf actpf en un rango de tiempo 
          def calcula_listado_ac(actividadpf_ids, fini, ffin)
            lac = Cor1440Gen::Actividad.joins(:actividadpf).
              where('fecha >= ?', fini).
              where('fecha <= ?', ffin)
            if actividadpf_ids.count > 0
              lac = lac.where(:'cor1440_gen_actividadpf.id' =>
                              actividadpf_ids)
            else
              lac = lac.where('FALSE')
            end

            return lac.pluck(:id).uniq
          end


          # De las tablas con cuentas de población de las actividaddes con
          # ids idacs, suma los diversos rangos de edad para el sexo dado
          def calcula_poblacion_tabla_sexo(idacs, fini, ffin, sexo)
            Cor1440Gen::ActividadRangoedadac.
              where(actividad_id: idacs).
              sum(sexo.to_sym)
          end

          # Cuenta personas unicas asistentes a actividades de listado lac 
          # Retorna listado de ids diferentes
          def asistencia_por_sexo(idacs, sexo)
            Cor1440Gen::Asistencia.joins(:persona).
              where(actividad_id: idacs).
              where('sip_persona.sexo = ?', sexo).pluck(:persona_id).uniq
          end

          # Mide indicador de resultado con métodos muy generales
          # Por tipos de indicador 1,2 y 3 o en su defecto
          #   cuenta de actividades con actividad de convenio en el 
          #   mismo resultado del indicador que se mide.
          #   Eso basta para marcos lógicos muy simples con un indicador 
          #   por resultado y una actividad por resultado.
          # Para otros casos debe especificarse la función de medición 
          #   sobrecargando mideindicador_particular que puede llamara
          #   a esta para los casos generales
          def mideindicador_cor1440_gen(mind, ind, fini, ffin)
            resind = 0.0
            idacs = []
            urlevrind = ''
            d1 = 0.0
            urlev1 = ''
            d2 = 0.0
            urlev2 = ''
            d3 = 0.0
            urlev3 = ''
           
            case ind.tipoindicador_id
            when 1 # Contar actividades con actividades de convenio espec.
              # Sin cuentas intermedias
              idacs = calcula_listado_ac(mind.actividadpf_ids, fini, ffin)
              resind = idacs.count
            when 2 # Contar población de tabla etarea en actividades y 
              # cuentas intermedias por sexo
              idacs = calcula_listado_ac(mind.actividadpf_ids, fini, ffin)
              d1 = calcula_poblacion_tabla_sexo(idacs, fini, ffin, 'fr')
              d2 = calcula_poblacion_tabla_sexo(idacs, fini, ffin, 'mr')
              d3 = calcula_poblacion_tabla_sexo(idacs, fini, ffin, 's')
              resind = d1+d2+d3

            when 3 # Contar asistentes únicos en listados de asistencia 
              # de actividades y cuentas intermedias por sexo
              idacs = calcula_listado_ac(mind.actividadpf_ids, fini, ffin)
              mujeres = asistencia_por_sexo(idacs, 'F')
              hombres = asistencia_por_sexo(idacs, 'M')
              sinsexo = asistencia_por_sexo(idacs, 'S')
              resind =  mujeres.count + hombres.count + sinsexo.count
              d1 = mujeres.count
              if d1 > 0
                urlev1 = sip.personas_url + '?filtro[busid]=' + 
                  mujeres.join(',')
              end
              d2 = hombres.count
              if d2 > 0
                urlev2 = sip.personas_url + '?filtro[busid]=' + 
                  hombres.join(',')
              end
              d3 = sinsexo.count
              if d3 > 0
                urlev3 = sip.personas_url + '?filtro[busid]=' + 
                  sinsexo.join(',')
              end
            else
              res = ind.resultadopf
              if res.actividadpf.count > 0
                idacs = calcula_listado_ac(mind.actividadpf_ids, fini, ffin)
                resind = idacs.count
              end
            end
            # Evidencia de resultado principal son actividades con ids idacs
            if resind > 0
              urlevrind = cor1440_gen.actividades_url +
                '?filtro[busid]='+idacs.join(',')
            end

            return [resind, urlevrind, d1, urlev1, d2, urlev2, d3, urlev3]
          end


          # Por sobrecargar. Recibe indicador y fecha inicial y 
          #   final de medicion
          # Retorna arreglo con medicioń de indicador así:
          # [resind, urlevrind, d1, urlev1, d2, urlev2, d3, urlev3] siendo
          # resind Resultado del indicador
          # urlevrind Url que verificar resultado
          # d1 Dato intermedio 1
          # urlev1 URL que verifica dato intermedio 1
          # d1 Dato intermedio 2
          # urlev2 URL que verifica dato intermedio 2
          # d1 Dato intermedio 3
          # urlev2 URL que verifica dato intermedio 3
          def mideindicador_particular(mind, ind, fini, ffin)
            resind = 0.0
            urlevrind = ''
            d1 = 0.0
            urlev1 = ''
            d2 = 0.0
            urlev2 = ''
            d3 = 0.0
            urlev3 = ''
            case ind.numero
            when 'ejemplo_loco1' 
              resind=2
            else
              return mideindicador_cor1440_gen(mind, ind, fini, ffin)
            end
            return [resind, urlevrind, d1, urlev1, d2, urlev2, d3, urlev3]
          end


          # Mide indicador
          # Calcula medición de un indicador con parametros que vienen en param
          def mideindicador
            prob = ''
            if params[:finicio_localizada] && 
              params[:ffin_localizada] && params[:indicadorpf_id] &&
              params[:hmindicadorpf_id] && params[:mindicadorpf_id] &&
              params[:mindicadorpf_id].to_i > 0
              fini = Sip::FormatoFechaHelper.fecha_local_estandar(
                params[:finicio_localizada])
              fini = Date.strptime(fini, '%Y-%m-%d')
              ffin = Sip::FormatoFechaHelper.fecha_local_estandar(
                params[:ffin_localizada])
              ffin = Date.strptime(ffin, '%Y-%m-%d')
              indid = params[:indicadorpf_id].to_i
              ind = Cor1440Gen::Indicadorpf.find(indid)
              hmi = params[:hmindicadorpf_id].to_i
              mi = params[:mindicadorpf_id].to_i
              mind = Cor1440Gen::Mindicadorpf.find(mi)
              if fini && ffin && ind
                rl = mideindicador_particular(mind, ind, fini, ffin)
                resind = rl[0]
                urlevrind = rl[1]
                d1 = rl[2]
                urlev1 = rl[3]
                d2 = rl[4]
                urlev2 = rl[5]
                d3 = rl[6]
                urlev3 = rl[7]

                respond_to do |format|
                  format.json { 
                    render json: {
                      fechaloc:  Sip::FormatoFechaHelper.fecha_estandar_local(
                        Date.today),
                        hmindicadorpf_id: hmi, 
                        dmed1: d1, 
                        urlev1: urlev1,
                        dmed2: d2, 
                        urlev2: urlev2,
                        dmed3: d3, 
                        urlev3: urlev3,
                        rind: resind,
                        urlevrind: urlevrind }, 
                        status: :ok
                        return
                  }
                end
              else
                prob = 'Falla al convertir parametros'
              end
            else
              prob = 'Indispensables parametros fechaini_localizada ' +
                ', fechacierre_localizada e indicadorpf_id'
            end
            respond_to do |format|
              format.html { render action: "error" }
              format.json { render json: prob, 
                status: :unprocessable_entity 
              }
            end
          end

          def genclase
            return 'F'
          end

          private
          # Use callbacks to share common setup or constraints between actions.
          def set_mindicadorpf
            @registro = @mindicadorpf = Mindicadorpf.find(params[:id])
          end

          # Never trust parameters from the scary internet, only allow the white list through.
          def mindicadorpf_params
            params.require(:mindicadorpf).permit(
              atributos_form - ["pmindicador", :actividadpf] +
              [:actividadpf_ids => []] +
              [
                'pmindicador_attributes' => [
                  'fecha_localizada', 
                  'finicio_localizada', 
                  'ffin_localizada', 
                  'restiempo', 
                  'dmed1', 
                  'urlev1', 
                  'dmed2', 
                  'urlev2', 
                  'dmed3', 
                  'urlev3', 
                  'rind', 
                  'urlevrind', 
                  'meta', 
                  'porcump', 
                  'analisis', 
                  'acciones', 
                  'responsables', 
                  'plazo', 
                  'id', 
                  '_destroy'
            ]
            ]
            ) 
          end

        end # included

      end 
    end
  end
end

