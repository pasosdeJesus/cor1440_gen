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
            [ :id,
              #:proyectofinanciero_id,
              :indicadorpf_id,
              :frecuenciaanual,
              :pmindicadorpf
            ]
          end

          def atributos_form
            [ :proyectofinanciero_id,
              :indicadorpf_id] +
              (@registro && @registro.indicadorpf && 
               @registro.indicadorpf.resultadopf ? [:actividadpf] : []) +
            [
              :frecuenciaanual,
              :pmindicadorpf
            ]
          end

          def atributos_show
            [ :id,
              :proyectofinanciero_id,
              :indicadorpf_id,
              :tipoindicador,
              :actividadpf,
              :frecuenciaanual,
              :pmindicadorpf
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

          def create
            def crea_pmindicadorpf(mind, fini, ffin, num, np)
              pm = Cor1440Gen::Pmindicadorpf.create(
                mindicadorpf_id: mind.id,
                finicio: fini,
                ffin: ffin,
                restiempo: "#{num} #{np}",
                meta: num)
              pm.save
              if mind.indicadorpf.tipoindicador && 
                  mind.indicadorpf.tipoindicador.datointermedioti 
                dids = mind.indicadorpf.tipoindicador.datointermedioti.
                  map(&:id)
                dids.each do |di|
                  dp = Cor1440Gen::DatointermediotiPmindicadorpf.create(
                    pmindicadorpf_id: pm.id,
                    datointermedioti_id: di
                  )
                  dp.save
                end
              end
            end

            authorize! :new, clase.constantize
            # Crear puntos de medición de acuerdo a frecuencia
            registro = Cor1440Gen::Mindicadorpf.new(mindicadorpf_params)
            if registro.valid? && registro.frecuenciaanual &&
                registro.proyectofinanciero &&
                registro.proyectofinanciero.fechainicio &&
                registro.proyectofinanciero.fechacierre
              registro.save
              if registro.valid? 
                f1 = registro.proyectofinanciero.fechainicio
                f2 = registro.proyectofinanciero.fechacierre
                if registro.frecuenciaanual.to_f > 0
                  cm = 12/registro.frecuenciaanual.to_f
                elsif registro.frecuenciaanual == '0,33'
                  cm = 36
                else
                  cm = 60
                end
                cm = cm > 1 ? cm.to_i : 1
                fi = f1 + cm.months
                case cm
                when 1
                  np = 'MES(ES)'
                when 2
                  np = 'BIMESTRE(S)'
                when 3
                  np = 'TRIMESTRE(S)'
                when 4
                  np = 'CUADRIMESTRE(S)'
                when 6
                  np = 'SEMESTRE(S)'
                when 12
                  np = 'AÑO(S)'
                when 36
                  np = 'TRIENIO(S)'
                else
                  np = 'QUINQUENIO(S)'
                end
                num = 1
                while fi<f2
                  crea_pmindicadorpf(registro, f1, fi-1, num, np)
                  fi += cm.months
                  num += 1
                end
                if f1<f2
                  crea_pmindicadorpf(registro, f1, f2, num, np)
                end 
              end
            end
            create_gen(registro)
          end

          # Descr
          def descripciones_datos_intermedios(mindicador)
            if mindicador.indicadorpf.tipoindicador.nil? || 
                mindicador.indicadorpf.tipoindicador.datointermedioti.nil? ||
                mindicador.indicadorpf.tipoindicador.datointermedioti.count == 0
              return []
            end
            return mindicador.indicadorpf.tipoindicador.datointermedioti.
              pluck(:nombre)
          end


          # De las tablas con cuentas de población de las actividaddes con
          # ids idacs, suma los diversos rangos de edad para el sexo dado
          def calcula_poblacion_tabla_sexo(idacs, fini, ffin, sexo)
            Cor1440Gen::ActividadRangoedadac.
              where(actividad_id: idacs).
              sum(sexo.to_sym)
          end

          # Cuenta asistentes a actividades de listado lac 
          # Retorna listado de ids.  Será únicas si uncas es verdadero diferentes
          def asistencia_por_sexo(idacs, sexo, unicas = false)
            res = Cor1440Gen::Asistencia.joins(:persona).
              where(actividad_id: idacs).
              where('sip_persona.sexo = ?', sexo).pluck(:persona_id)
            if unicas
              res = res.uniq
            end
            return res
          end

          # Mide indicador de resultado tipo 1. Cantidad de actividades
          # No retorna datos intermedios
          def medir_indicador_res_tipo_1(idacs, mind, fini, ffin)
            return {resind: idacs.count, datosint: []}
          end

          # Mide indicador de resultado tipo 2. Suma de poblaciones tomadas
          # de tablas población de cada actividad. Puede incluir repetidos.
          # Los datos intermedios que retorna son mujeres, hombres y sin sexo de nacimiento
          # No retorna  para esos datos intermedios (serían las
          # mismas actividades que n el resultado).
          def medir_indicador_res_tipo_2(idacs, mind, fini, ffin)
            datosint = []
            d1 = calcula_poblacion_tabla_sexo(idacs, fini, ffin, 'fr')
            d2 = calcula_poblacion_tabla_sexo(idacs, fini, ffin, 'mr')
            d3 = calcula_poblacion_tabla_sexo(idacs, fini, ffin, 's')
            resind = d1+d2+d3
            datosint << {valor: d1, rutaevidencia: '#'}
            datosint << {valor: d2, rutaevidencia: '#'}
            datosint << {valor: d3, rutaevidencia: '#'}

            return {resind: resind, datosint: datosint}
          end

          # Mide indicador de resultado tipo 3. Cantidad de asistentes
          # en listados de asistencia. Puede incluir repetidos
          # Los datos intermedios que retorna son mujeres, hombres y 
          # sin sexo de nacimiento
          # La  que retorna en cada caso es lista de mujeres,
          # lista de hombres y de sin sexo de nacimiento.
          def medir_indicador_res_tipo_3(idacs, mind, fini, ffin)
            datosint = []
            mujeres = asistencia_por_sexo(idacs, 'F', false)
            hombres = asistencia_por_sexo(idacs, 'M', false)
            sinsexo = asistencia_por_sexo(idacs, 'S', false)
            resind =  mujeres.count + hombres.count + sinsexo.count
            datosint << {valor: mujeres.count, rutaevidencia: '#'}
            datosint << {valor: hombres.count, rutaevidencia: '#'}
            datosint << {valor: sinsexo.count, rutaevidencia: '#'}
            if datosint[0][:valor] > 0 # mujeres
                datosint[0][:rutaevidencia] = sip.personas_path+ '?filtro[busid]=' + 
                  mujeres.join(',')
            end
            if datosint[1][:valor] > 0 # hombres
              datosint[1][:rutaevidencia] = sip.personas_path + 
                '?filtro[busid]=' + hombres.join(',')
            end
            if datosint[2][:valor] > 0 # sin sexo nac
              datosint[2][:rutaevidencia] = sip.personas_path + 
                '?filtro[busid]=' + sinsexo.join(',')
            end

            return {resind: resind, datosint: datosint}
          end

          # Mide indicador de resultado tipo 4. Cantidad de asistentes únicos
          # en listados de asistencia. No incluye repetidos
          # Los datos intermedios que retorna son mujeres únicas, 
          # hombres únicos y sin sexo de nacimiento únicos
          # La  evidencia que retorna en cada caso es lista de mujeres,
          # lista de hombres y lista de sin sexo de nacimiento.
          def medir_indicador_res_tipo_4(idacs, mind, fini, ffin)
            datosint = []
            mujeres = asistencia_por_sexo(idacs, 'F', true)
            hombres = asistencia_por_sexo(idacs, 'M', true)
            sinsexo = asistencia_por_sexo(idacs, 'S', true)
            resind =  mujeres.count + hombres.count + sinsexo.count
            datosint << {valor: mujeres.count, rutaevidencia: '#'}
            datosint << {valor: hombres.count, rutaevidencia: '#'}
            datosint << {valor: sinsexo.count, rutaevidencia: '#'}
            if datosint[0][:valor] > 0 # mujeres
                datosint[0][:rutaevidencia] = sip.personas_path+ '?filtro[busid]=' + 
                  mujeres.join(',')
              end
              if datosint[1][:valor] > 0 # hombres
                datosint[1][:rutaevidencia] = sip.personas_path+ '?filtro[busid]=' + 
                  hombres.join(',')
              end
              if datosint[2][:valor] > 0 # sin sexo nac
                datosint[2][:rutaevidencia] = sip.personas_path+ '?filtro[busid]=' + 
                  sinsexo.join(',')
              end

            return {resind: resind, datosint: datosint}
          end



          # Recibe medición de indicador por completar
          #   y fecha inicial y final de medicion
          # Retorna objeto con 
          # {resind: resind, rutaevidencia: rutaevidencia, datosint: datosint}
          # resind Resultado del indicador
          # rutaevidencia: Ruta que verificar resultado o '#'
          # datosint Datos intermedios, arreglo con objetos de la forma
          # {valor: valor, rutaevidencia: rutaevidencia}
          # valor es dato intermedio
          # rutaevidencia es ruta que verifica dato intermedio o '#'
          def medir_indicador_particular(mind, fini, ffin)
            resf = {resind: -1.0, rutaevidencia: '#', datosint: []} 

            ind = mind.indicadorpf
            if ind.nil?
              puts "Error: Medición sin indicador"
              return resf
            end
            if ind.tipoindicador.nil?
              puts "Error: Indicador sin tipo"
              return resf
            end

            if ind.tipoindicador.medircon == 1 # Actividades
              idacs = []
              idacs = calcula_listado_ac(mind.actividadpf_ids, fini, ffin)
              if self.respond_to?('medir_indicador_res_tipo_' + 
                  ind.tipoindicador_id.to_s)
                resf = self.send('medir_indicador_res_tipo_' + 
                                 ind.tipoindicador_id.to_s,
                                 idacs, mind, fini, ffin)
                if resf[:datosint].count != ind.tipoindicador.datointermedioti.count
                  puts "Error. No coinciden resf.datosint.count ({#resf.datosint.count} y ind.tipoindicador.datointermedioti.count (#{ind.tipindicador.datointermedioti.count})."
                end
                # Evidencia de resultado principal son actividades con ids idacs
                if idacs.count > 0
                  resf[:rutaevidencia] = cor1440_gen.actividades_path +
                    '?filtro[busid]='+idacs.join(',')
                end
              end
            elsif ind.tipoindicador.medircon == 2 # Efectos

            elsif ind.tipoindicador.medircon == 3 # Proyectos
              # Medición interna 
              # ...
            end

            return resf
          end


          # Mide indicador
          # Calcula medición de un indicador con parametros que vienen en param
          def medir_indicador
            prob = ''
            if params[:finicio_localizada] && 
              params[:finicio_localizada] != '' && 
              params[:ffin_localizada] && 
              params[:ffin_localizada] != '' && 
              params[:indicadorpf_id] &&
              params[:indicadorpf_id] != '' &&
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
              if fini && ffin && ind && mind.indicadorpf_id == indid
                rl = medir_indicador_particular(mind, fini, ffin)
                respond_to do |format|
                  format.json { 
                    render json: { 
                      fechaloc:  Sip::FormatoFechaHelper.fecha_estandar_local(
                        Date.today),
                      hmindicadorpf_id: hmi, 
                      datosint: rl[:datosint],
                      resind: rl[:resind],
                      rutaevidencia: rl[:rutaevidencia]}, 
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
              atributos_form - ["pmindicadorpf", :actividadpf] +
              [:actividadpf_ids => []] +
              [
                'pmindicadorpf_attributes' => [
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
                  'resind', 
                  'rutaevidencia', 
                  'meta', 
                  'porcump', 
                  'analisis', 
                  'acciones', 
                  'responsables', 
                  'plazo', 
                  'id', 
                  '_destroy',
                  'datointermedioti_pmindicadorpf_attributes' => [
                    :valor,
                    :rutaevidencia,
                    :datointermedioti_id,
                    :id
                  ]
                ]
              ]
            ) 
          end

        end # included

      end 
    end
  end
end

