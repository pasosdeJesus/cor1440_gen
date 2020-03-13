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
              "indicadorpf_id",
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

          # Mide indicador de resultado con método muy general
          # Suponemos que se aporta uno al indicador cuando se realiza una actividad
          # cuya actividad de proyecto financiero es del mismo resultado del indicador.
          # Esto basta para marcos lógicos muy simples con un indicador por resultado
          # y una actividad por resultado.
          # Para otros debe especificarse la función de medición sobrecargando mideindicador_particular
          def mideindicador_cor1440_gen(ind, fini, ffin)
            # Contar categorias de actividad relacionadas 
            # con el resultado en el periodo
            resind = 0.0
            urlevrind = ''
            d1 = 0.0
            urlev1 = ''
            d2 = 0.0
            urlev2 = ''
            d3 = 0.0
            urlev3 = ''

            res = ind.resultadopf
            if res.actividadpf.count > 0
              lac = Cor1440Gen::Actividad.joins(:actividadpf).
                where('cor1440_gen_actividadpf.id IN (?)', res.actividadpf_ids).
                where('fecha >= ?', fini).
                where('fecha <= ?', ffin).
                pluck(:id).uniq
              resind = lac.count
              if resind > 0
                urlevrind = cor1440_gen.actividades_url +
                  '?filtro[busid]='+lac.join(',')
              end
            end
            return [resind, urlevrind, d1, urlev1, d2, urlev2, d3, urlev3]
          end

          # Por sobrecargar. Recibe indicador y fecha inicial y final de medicion
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
          def mideindicador_particular(ind, fini, ffin)
            resind = 0.0
            urlevrind = ''
            d1 = 0.0
            urlev1 = ''
            d2 = 0.0
            urlev2 = ''
            d3 = 0.0
            urlev3 = ''
            tipoind = ind.tipoindicador
            if tipoind
              case tipoind.nombre
              when 'ejemplo-por-sobrecargar'
                resind = 5
              end
            else
              return mideindicador_cor1440_gen(ind, fini, ffin)
            end
            return [resind, urlevrind, d1, urlev1, d2, urlev2, d3, urlev3]
          end


          # Mide indicador
          # Calcula medición de un indicador con parametros que vienen en param
          def mideindicador
            prob = ''
            if params[:finicio_localizada] && 
              params[:ffin_localizada] && params[:indicadorpf_id] &&
              params[:hmindicadorpf_id] 
              fini = Sip::FormatoFechaHelper.fecha_local_estandar(
                params[:finicio_localizada])
              fini = Date.strptime(fini, '%Y-%m-%d')
              ffin = Sip::FormatoFechaHelper.fecha_local_estandar(
                params[:ffin_localizada])
              ffin = Date.strptime(ffin, '%Y-%m-%d')
              indid = params[:indicadorpf_id].to_i
              ind = Cor1440Gen::Indicadorpf.find(indid)
              hmi = params[:hmindicadorpf_id].to_i
              if fini && ffin && ind
                rl = mideindicador_particular(ind, fini, ffin)
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
              atributos_form - ["pmindicador"] + [
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

