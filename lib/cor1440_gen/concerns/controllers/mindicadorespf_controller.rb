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
              "proyectofinanciero_id",
              "indicadorpf_id",
              "frecuenciaanual",
              "pmindicador"
            ]
          end

          def index_reordenar(registros)
            return registros.reorder(proyectofinanciero_id: :asc, 
                                     indicadorpf_id: :asc)
          end

          def new_modelo_path(o)
            return new_minidicadorpf_path()
          end

          # Mide indicador
          # Calcula medición de un indicador
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
              tipoind = ind.tipoindicador
              hmi = params[:hmindicadorpf_id].to_i
              if fini && ffin && ind && tipoind
                resind = 0.0
                urlevrind = ''
                d1 = 0.0
                urlev1 = ''
                d2 = 0.0
                urlev2 = ''
                d3 = 0.0
                urlev3 = ''
                case tipoind.nombre
                when 'IG-FG-01'
                  # Participacion efectiva en convocatorias
                  base = Cor1440Gen::Proyectofinanciero.
                    where('fechaformulacion >= ?', fini).
                    where('fechaformulacion <= ?', ffin).
                    where('respgp_id IS NOT NULL')
                  cd1 = base.clone.where(
                    'estado IN (?)', ::ApplicationHelper::ESTADOS_APROBADO) 
                  d1 = cd1.count
                  evd1 = cd1.pluck('id')
                  urlev1 = cor1440_gen.proyectosfinancieros_url +
                    '?filtro[busid]='+evd1.join(',')
                  cd2 = base.clone
                  d2 = cd2.count
                  evd2 = cd2.pluck('id')
                  urlev2 = cor1440_gen.proyectosfinancieros_url +
                    '?filtro[busid]='+evd2.join(',')
                  resind = d2.to_f > 0 ? 100*d1.to_f/d2.to_f : nil;
               else
                 base = "SELECT COUNT(*) FROM efecto WHERE 
                 fecha>='#{fini}' AND fecha<='#{ffin}'
                 AND indicadorpf_id='#{ind.id}'"
                 d1 = ActiveRecord::Base.connection.execute(base).
                   first['count'].to_f
                 resind = d1
               end

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

