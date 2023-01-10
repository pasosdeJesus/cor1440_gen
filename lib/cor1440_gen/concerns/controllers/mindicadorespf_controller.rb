# frozen_string_literal: true

module Cor1440Gen
  module Concerns
    module Controllers
      module MindicadorespfController
        extend ActiveSupport::Concern

        included do
          def clase
            "Cor1440Gen::Mindicadorpf"
          end

          def atributos_index
            [
              :id,
              # :proyectofinanciero_id,
              :indicadorpf_id,
              :frecuenciaanual,
              :pmindicadorpf,
            ]
          end

          def atributos_form
            [
              :proyectofinanciero_id,
              :indicadorpf_id,
              :medircon,
              :formulario,
            ] +
              (@registro && @registro.indicadorpf ? [:actividadpf] : []) +
              [
                :datointermedioti,
                :funcionresultado,
                :frecuenciaanual,
                :pmindicadorpf,
              ]
          end

          def atributos_show
            [
              :pmindicadorpf,
              :id,
              :proyectofinanciero_id,
              :indicadorpf_id,
              :medircon,
            ] + (
              if @registro.medircon == 1
                [:actividadpf]
              else
                (if @registro.medircon == 2
                   [:formulario]
                 else
                   []
                 end
                )
              end
            ) + [
              :datointermedioti,
              :funcionresultado,
              :frecuenciaanual,
            ]
          end

          def index_reordenar(registros)
            @contar_pf = Cor1440Gen::Proyectofinanciero.all
            @contar_pfid = if params[:filtro] &&
                params[:filtro][:busproyectofinanciero_id]
              params[:filtro][:busproyectofinanciero_id].to_i
            else
              (@contar_pfid or nil)
            end

            registros.where(proyectofinanciero_id: @contar_pfid)
              .reorder(proyectofinanciero_id: :asc, indicadorpf_id: :asc)
          end

          def new_modelo_path(o)
            new_minidicadorpf_path
          end

          # Retorna listado de ids diferentes de
          #   actividades con actividadpf actpf en un rango de tiempo
          def calcula_listado_ac(actividadpf_ids, fini, ffin)
            lac = Cor1440Gen::Actividad.joins(:actividadpf)
              .where("fecha >= ?", fini)
              .where("fecha <= ?", ffin)
            lac = if actividadpf_ids.count > 0
              lac.where("cor1440_gen_actividadpf.id": actividadpf_ids)
            else
              lac.where("FALSE")
            end

            lac.pluck(:id).uniq
          end

          def self.calcula_listado_ef(indicadorpf_id, fini, ffin)
            lef = Cor1440Gen::Efecto
              .where(indicadorpf_id: indicadorpf_id)
              .where("fecha >= ?", fini)
              .where("fecha <= ?", ffin)

            lef.pluck(:id).uniq
          end

          def create
            def crea_pmindicadorpf(mind, fini, ffin, num, np)
              pm = Cor1440Gen::Pmindicadorpf.create(
                mindicadorpf_id: mind.id,
                finicio: fini,
                ffin: ffin,
                restiempo: "#{num} #{np}",
                meta: num,
              )
              pm.save
              if mind.indicadorpf.tipoindicador &&
                  mind.indicadorpf.tipoindicador.datointermedioti
                dids = mind.indicadorpf.tipoindicador.datointermedioti
                  .map(&:id)
                dids.each do |di|
                  dp = Cor1440Gen::DatointermediotiPmindicadorpf.create(
                    pmindicadorpf_id: pm.id,
                    datointermedioti_id: di,
                  )
                  dp.save
                end
              end
            end

            authorize!(:new, clase.constantize)
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
                cm = if registro.frecuenciaanual.to_f > 0
                  12 / registro.frecuenciaanual.to_f
                elsif registro.frecuenciaanual == "0,33"
                  36
                else
                  60
                end
                cm = cm > 1 ? cm.to_i : 1
                fi = f1 + cm.months
                np = case cm
                when 1
                  "MES(ES)"
                when 2
                  "BIMESTRE(S)"
                when 3
                  "TRIMESTRE(S)"
                when 4
                  "CUADRIMESTRE(S)"
                when 6
                  "SEMESTRE(S)"
                when 12
                  "AÑO(S)"
                when 36
                  "TRIENIO(S)"
                else
                  "QUINQUENIO(S)"
                end
                num = 1
                while fi < f2
                  crea_pmindicadorpf(registro, f1, fi - 1, num, np)
                  fi += cm.months
                  num += 1
                end
                if f1 < f2
                  crea_pmindicadorpf(registro, f1, f2, num, np)
                end
              end
            end
            create_gen(registro)
          end

          # Descr
          def descripciones_datos_intermedios(mindicadorpf)
            if mindicadorpf.datointermedioti
              mindicadorpf.datointermedioti.pluck(:nombre)
            else
              if mindicadorpf.indicadorpf.tipoindicador.nil? ||
                  mindicadorpf.indicadorpf.tipoindicador.datointermedioti.nil? ||
                  mindicadorpf.indicadorpf.tipoindicador.datointermedioti.count == 0
                return []
              end

              mindicadorpf.indicadorpf.tipoindicador.datointermedioti
                .pluck(:nombre)
            end
          end

          # De las tablas con cuentas de población de las actividaddes con
          # ids idacs, suma los diversos rangos de edad para el sexo dado
          def calcula_poblacion_tabla_sexo(idacs, fini, ffin, sexo)
            Cor1440Gen::ActividadRangoedadac
              .where(actividad_id: idacs)
              .sum(sexo.to_sym)
          end

          # Cuenta asistentes a actividades de listado lac
          # Retorna listado de ids.  Serán únicas si unicas es verdadero
          def asistencia_por_sexo(idacs, sexo, unicas = false)
            res = Cor1440Gen::Asistencia.joins(:persona)
              .where(actividad_id: idacs)
              .where("msip_persona.sexo = ?", sexo).pluck(:persona_id)
            if unicas
              res = res.uniq
            end
            res
          end

          # Mide indicador de resultado tipo 1. Cantidad de actividades
          # No retorna datos intermedios
          def medir_indicador_res_tipo_1(idacs, mind, fini, ffin)
            { resind: idacs.count, datosint: [] }
          end

          # Mide indicador de resultado tipo 2. Suma de poblaciones tomadas
          # de tablas población de cada actividad. Puede incluir repetidos.
          # Los datos intermedios que retorna son mujeres, hombres y sin
          # sexo de nacimiento
          # No retorna  para esos datos intermedios (serían las
          # mismas actividades que n el resultado).
          def medir_indicador_res_tipo_2(idacs, mind, fini, ffin)
            datosint = []
            d1 = calcula_poblacion_tabla_sexo(idacs, fini, ffin, "fr")
            d2 = calcula_poblacion_tabla_sexo(idacs, fini, ffin, "mr")
            d3 = calcula_poblacion_tabla_sexo(idacs, fini, ffin, "s")
            resind = d1 + d2 + d3
            datosint << { valor: d1, rutaevidencia: "#" }
            datosint << { valor: d2, rutaevidencia: "#" }
            datosint << { valor: d3, rutaevidencia: "#" }

            { resind: resind, datosint: datosint }
          end

          # Mide indicador de resultado tipo 3. Cantidad de asistentes
          # en listados de asistencia. Puede incluir repetidos
          # Los datos intermedios que retorna son mujeres, hombres y
          # sin sexo de nacimiento
          # La  que retorna en cada caso es lista de mujeres,
          # lista de hombres y de sin sexo de nacimiento.
          def medir_indicador_res_tipo_3(idacs, mind, fini, ffin)
            datosint = []
            mujeres = asistencia_por_sexo(idacs, "F", false)
            hombres = asistencia_por_sexo(idacs, "M", false)
            sinsexo = asistencia_por_sexo(idacs, "S", false)
            resind =  mujeres.count + hombres.count + sinsexo.count
            datosint << { valor: mujeres.count, rutaevidencia: "#" }
            datosint << { valor: hombres.count, rutaevidencia: "#" }
            datosint << { valor: sinsexo.count, rutaevidencia: "#" }
            if datosint[0][:valor] > 0 # mujeres
              datosint[0][:rutaevidencia] = msip.personas_path + "?filtro[busid]=" +
                mujeres.join(",")
            end
            if datosint[1][:valor] > 0 # hombres
              datosint[1][:rutaevidencia] = msip.personas_path +
                "?filtro[busid]=" + hombres.join(",")
            end
            if datosint[2][:valor] > 0 # sin sexo nac
              datosint[2][:rutaevidencia] = msip.personas_path +
                "?filtro[busid]=" + sinsexo.join(",")
            end

            { resind: resind, datosint: datosint }
          end

          # Mide indicador de resultado tipo 4. Cantidad de asistentes únicos
          # en listados de asistencia. No incluye repetidos
          # Los datos intermedios que retorna son mujeres únicas,
          # hombres únicos y sin sexo de nacimiento únicos
          # La  evidencia que retorna en cada caso es lista de mujeres,
          # lista de hombres y lista de sin sexo de nacimiento.
          def medir_indicador_res_tipo_4(idacs, mind, fini, ffin)
            datosint = []
            mujeres = asistencia_por_sexo(idacs, "F", true)
            hombres = asistencia_por_sexo(idacs, "M", true)
            sinsexo = asistencia_por_sexo(idacs, "S", true)
            resind =  mujeres.count + hombres.count + sinsexo.count
            datosint << { valor: mujeres.count, rutaevidencia: "#" }
            datosint << { valor: hombres.count, rutaevidencia: "#" }
            datosint << { valor: sinsexo.count, rutaevidencia: "#" }
            if datosint[0][:valor] > 0 # mujeres
              datosint[0][:rutaevidencia] = msip.personas_path + "?filtro[busid]=" +
                mujeres.join(",")
            end
            if datosint[1][:valor] > 0 # hombres
              datosint[1][:rutaevidencia] = msip.personas_path + "?filtro[busid]=" +
                hombres.join(",")
            end
            if datosint[2][:valor] > 0 # sin sexo nac
              datosint[2][:rutaevidencia] = msip.personas_path + "?filtro[busid]=" +
                sinsexo.join(",")
            end

            { resind: resind, datosint: datosint }
          end

          # Mide indicador de resultado tipo 5. Participaciones
          # de organizaciones en las actividades
          # No retorna datos intermedios
          def medir_indicador_res_tipo_5(idacs, mind, fini, ffin)
            r = Cor1440Gen::ActividadOrgsocial.where(actividad_id: idacs).count(:all)
            { resind: r, datosint: [] }
          end

          # Mide indicador de resultado tipo 6. Organizaciones diferentes
          # en las actividades con ids idacs
          # No retorna datos intermedios
          def medir_indicador_res_tipo_6(idacs, mind, fini, ffin)
            r = 0
            if idacs && idacs.count > 0
              puts "idacs=#{idacs.inspect}"
              r = Cor1440Gen::Actividad.connection.execute(
                "SELECT COUNT(DISTINCT orgsocial_id) "\
                  "FROM cor1440_gen_actividad_orgsocial "\
                  "WHERE actividad_id IN (#{idacs.join(",")})",
              ).count
            end
            { resind: r, datosint: [] }
          end

          def amplia_contexto(contexto)
            contexto
          end

          # Mide indicador de resultado
          def medir_indicador_resultado(mind, ind, fini, ffin, resf)
            idacs = []
            idacs = calcula_listado_ac(mind.actividadpf_ids, fini, ffin)
            if mind.funcionresultado.to_s != "" # Medir con esp de medicionindicadorpf
              contexto = {
                "Actividades_contribuyentes" =>
                Cor1440Gen::Actividad.where(id: idacs),
              }
              contexto = amplia_contexto(contexto)
              mind.datointermedioti.order(:id).each do |di|
                if di.nombreinterno.nil?
                  resf[:prob] = "Error: Falta nombre interno de dato intermedio #{di.id}"
                  puts resf[:prob]
                  return resf
                end
                if di.nombreinterno.nil?
                  resf[:prob] = "Error: Falta función de dato intermedio #{di.id}"
                  puts resf[:prob]
                  return resf
                end
                contexto[di.nombreinterno] = Cor1440Gen::MedicionHelper
                  .evalua_expresion_medicion(di.funcion.to_s,
                    contexto)
                resf[:datosint] << {
                  valor: contexto[di.nombreinterno],
                  rutaevidencia: "#",
                }
              end
              resf[:resind] = Cor1440Gen::MedicionHelper
                .evalua_expresion_medicion(mind.funcionresultado.to_s,
                  contexto)

            elsif respond_to?("medir_indicador_res_tipo_" +
                  ind.tipoindicador_id.to_s) # Medir mediante tipo
              resf = send(
                "medir_indicador_res_tipo_" +
                                                 ind.tipoindicador_id.to_s,
                idacs,
                mind,
                fini,
                ffin,
              )
              if resf[:datosint].count != ind.tipoindicador.datointermedioti.count
                puts "Error. No coinciden resf.datosint.count (#{resf[:datosint].count} y ind.tipoindicador.datointermedioti.count (#{ind.tipoindicador.datointermedioti.count})."
              end
            end
            # Evidencia de resultado principal son actividades con ids idacs
            if idacs.count > 0
              resf[:rutaevidencia] = cor1440_gen.actividades_path +
                "?filtro[busid]=" + idacs.join(",")
            end
            resf
          end

          # Mide indicador de efecto mediante avance tipo 10.
          # Cantidad de avances.
          # No retorna datos intermedios
          # idefs lista con identificación de efectos que aportan en el avance
          # mind Es objeto Cor1440Gen::Mindicadorpf con medición
          # fini Es fecha inicial de medición
          # ffin Es fecha final de medición
          def medir_indicador_efecto_tipo_10(idefs, mind, fini, ffin)
            { resind: idefs.count, datosint: [] }
          end

          # Mide indicador de efecto
          def medir_indicador_efecto(mind, ind, fini, ffin, resf)
            idefs = []
            idefs = Cor1440Gen::MindicadorespfController.calcula_listado_ef(
              mind.indicadorpf_id, fini, ffin
            )
            if mind.funcionresultado.to_s != ""
              # Medir con esp de medicionindicadorpf
              contexto = {
                "Efectos_contribuyentes" =>
                Cor1440Gen::Efecto.where(id: idefs),
              }
              contexto = amplia_contexto(contexto)

              mind.datointermedioti.order(:id).each do |di|
                if di.nombreinterno.nil?
                  resf[:prob] = "Error: Falta nombre interno de dato "\
                    "intermedio #{di.id}"
                  puts resf[:prob]
                  return resf
                end
                if di.nombreinterno.nil?
                  resf[:prob] = "Error: Falta función de dato "\
                    "intermedio #{di.id}"
                  puts resf[:prob]
                  return resf
                end
                contexto[di.nombreinterno] = Cor1440Gen::MedicionHelper
                  .evalua_expresion_medicion(di.funcion.to_s,
                    contexto)
                resf[:datosint] << {
                  valor: contexto[di.nombreinterno],
                  rutaevidencia: "#",
                }
              end
              resf[:resind] = Cor1440Gen::MedicionHelper
                .evalua_expresion_medicion(mind.funcionresultado.to_s,
                  contexto)

            elsif respond_to?("medir_indicador_efecto_tipo_" +
                  ind.tipoindicador_id.to_s) # Medir mediante tipo

              resf = send(
                "medir_indicador_efecto_tipo_" +
                                                 ind.tipoindicador_id.to_s,
                idefs,
                mind,
                fini,
                ffin,
              )
              if resf[:datosint].count != ind.tipoindicador.datointermedioti.count
                puts "Error. No coinciden resf.datosint.count (#{resf[:datosint].count} y ind.tipoindicador.datointermedioti.count (#{ind.tipoindicador.datointermedioti.count})."
              end
            end
            # Evidencia de resultado principal son efectos con ids idefs
            if idefs.count > 0
              resf[:rutaevidencia] = cor1440_gen.efectos_path +
                "?filtro[busid]=" + idefs.join(",")
            end

            resf
          end

          # Mide otra clase de indicador (ni efecto, ni resultado)
          def medir_indicador_otro(mind, ind, fini, ffin, resf)
            # evidencia de resultado principal debe ser retornada
            # en resf[:rutaevidencia]
            if respond_to?("medir_indicador_otro_tipo_" +
                ind.tipoindicador_id.to_s)
              resf = send(
                "medir_indicador_otro_tipo_" +
                                               ind.tipoindicador_id.to_s,
                mind,
                fini,
                ffin,
              )
              if resf[:datosint].count != ind.tipoindicador
                  .datointermedioti.count
                puts "Error. No coinciden resf.datosint.count " +
                  "(#{resf[:datosint].count} y " +
                  "ind.tipoindicador.datointermedioti.count " +
                  "(#{ind.tipoindicador.datointermedioti.count})."
              end
            end
            resf
          end

          # Recibe medición de indicador por completar
          #   y fecha inicial y final de medicion
          # Retorna objeto con
          # {resind: resind, rutaevidencia: rutaevidencia, datosint: datosint,
          # prob: prob}
          # resind Resultado del indicador
          # rutaevidencia: Ruta que verificar resultado o '#'
          # datosint Datos intermedios, arreglo con objetos de la forma
          # {valor: valor, rutaevidencia: rutaevidencia}
          # valor es dato intermedio
          # rutaevidencia es ruta que verifica dato intermedio o '#'
          # prob es cadena con problemas encontrados
          def medir_indicador_particular(mind, fini, ffin)
            resf = { resind: -1.0, rutaevidencia: "#", datosint: [], prob: "" }

            ind = mind.indicadorpf
            if ind.nil?
              resf[:prob] = "Error: Medición sin indicador"
              puts resf[:prob]
              return resf[:prob]
            end
            if ind.tipoindicador.nil? &&
                (mind.medircon.nil? || mind.funcionresultado.to_s == "")
              resf[:prob] = "Error: Medición sin especificar.  Indicador sin tipo"
              puts resf[:prob]
              return resf[:prob]
            end

            resf = if mind.medircon == 1 || (
                mind.funcionresultado.to_s == "" &&
                ind.tipoindicador.medircon == 1) # Actividades
              medir_indicador_resultado(mind, ind, fini, ffin, resf)
            elsif mind.medircon == 2 || (
              mind.funcionresultado.to_s == "" &&
              ind.tipoindicador.medircon == 2) # Efectos
              medir_indicador_efecto(mind, ind, fini, ffin, resf)
            else # Otros, e.g gestion de proyectos
              medir_indicador_otro(mind, ind, fini, ffin, resf)
            end

            resf
          end

          # Mide indicador
          # Calcula medición de un indicador con parametros que vienen en param
          def medir_indicador
            prob = ""
            if params[:finicio_localizada] &&
                params[:finicio_localizada] != "" &&
                params[:ffin_localizada] &&
                params[:ffin_localizada] != "" &&
                params[:indicadorpf_id] &&
                params[:indicadorpf_id] != "" &&
                params[:hmindicadorpf_id] && params[:mindicadorpf_id] &&
                params[:mindicadorpf_id].to_i > 0
              fini = Msip::FormatoFechaHelper.fecha_local_estandar(
                params[:finicio_localizada],
              )
              fini = Date.strptime(fini, "%Y-%m-%d")
              ffin = Msip::FormatoFechaHelper.fecha_local_estandar(
                params[:ffin_localizada],
              )
              ffin = Date.strptime(ffin, "%Y-%m-%d")
              indid = params[:indicadorpf_id].to_i
              ind = Cor1440Gen::Indicadorpf.find(indid)
              hmi = params[:hmindicadorpf_id].to_i
              mi = params[:mindicadorpf_id].to_i
              mind = Cor1440Gen::Mindicadorpf.find(mi)
              if fini && ffin && ind && mind.indicadorpf_id == indid
                rl = medir_indicador_particular(mind, fini, ffin)
                respond_to do |format|
                  format.json do
                    render(
                      json: {
                        fechaloc: Msip::FormatoFechaHelper.fecha_estandar_local(
                          Date.today,
                        ),
                        hmindicadorpf_id: hmi,
                        datosint: rl[:datosint],
                        resind: rl[:resind],
                        rutaevidencia: rl[:rutaevidencia],
                      },
                      status: :ok,
                    )
                    return
                  end
                end
              else
                prob = "Falla al convertir parametros"
              end
            else
              prob = "Indispensables parametros fechaini_localizada " +
                ", fechacierre_localizada e indicadorpf_id"
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

          def genclase
            "F"
          end

          private

          # Use callbacks to share common setup or constraints between actions.
          def set_mindicadorpf
            @registro = @mindicadorpf = Mindicadorpf.find(params[:id])
          end

          # Never trust parameters from the scary internet, only allow the white list through.
          def mindicadorpf_params
            params.require(:mindicadorpf).permit(
              atributos_form - [
                "pmindicadorpf",
                :actividadpf,
                :formulario,
                :datointermedioti,
              ] + [
                actividadpf_ids: [],
                formulario_ids: [],
              ] + [
                datointermedioti_attributes: [
                  :nombre,
                  :nombreinterno,
                  :funcion,
                  :id,
                  :_destroy,
                ],
              ] + [
                "pmindicadorpf_attributes" => [
                  "fecha_localizada",
                  "finicio_localizada",
                  "ffin_localizada",
                  "restiempo",
                  "dmed1",
                  "urlev1",
                  "dmed2",
                  "urlev2",
                  "dmed3",
                  "urlev3",
                  "resind",
                  "rutaevidencia",
                  "meta",
                  "porcump",
                  "analisis",
                  "acciones",
                  "responsables",
                  "plazo",
                  "id",
                  "_destroy",
                  "datointermedioti_pmindicadorpf_attributes" => [
                    :valor,
                    :rutaevidencia,
                    :datointermedioti_id,
                    :id,
                  ],
                ],
              ],
            )
          end
        end # included
      end
    end
  end
end
