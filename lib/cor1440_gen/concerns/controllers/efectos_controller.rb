# frozen_string_literal: true

module Cor1440Gen
  module Concerns
    module Controllers
      module EfectosController
        extend ActiveSupport::Concern

        included do
          helper ::ApplicationHelper

          def clase
            "Cor1440Gen::Efecto"
          end

          def atributos_index
            [
              :id,
              :indicadorpf_id,
            ] + [
              orgsocial_ids: [],
            ] + [
              :fecha_localizada,
              :nombre,
              :descripcion,
              :registradopor_id,
              :anexo_efecto,
            ]
          end

          def atributos_show
            r = atributos_index
            r
          end

          def atributos_form
            [:indicadorpf_id] +
              [orgsocial_ids: []] +
              [
                :fecha_localizada,
                :nombre,
                :descripcion,
                :respuestafor,
                :anexo_efecto,
              ]
          end

          def new
            @registro = clase.constantize.new
            @registro.fecha = Date.today
            if params[:indicadorpf_id] && params[:indicadorpf_id].to_i > 0
              @registro.indicadorpf_id = params[:indicadorpf_id].to_i
            end
            @registro.registradopor_id = current_usuario.id
            @registro.save!(validate: false)
            redirect_to(cor1440_gen.edit_efecto_path(@registro))
          end

          def asegura_camposdinamicos(efecto, current_usuario_id)
            vfid = [] # ids de formularios que deben presentarse

            if efecto.indicadorpf && efecto.indicadorpf.tipoindicador &&
                efecto.indicadorpf.tipoindicador.formulario
              fids = efecto.indicadorpf.tipoindicador.formulario_ids
            end
            if efecto.indicadorpf && efecto.indicadorpf.mindicador
              fids += efecto.indicadorpf.mindicador.map(&:formulario_ids)
                .flatten
            end

            Mr519Gen::Formulario.where(id: fids).each do |f|
              vfid << f.id
              aw = efecto.respuestafor.where(formulario_id: f.id)
              if aw.count == 0
                rf = Mr519Gen::Respuestafor.create(
                  formulario_id: f.id,
                  fechaini: Date.today,
                  fechacambio: Date.today,
                )
                er = Cor1440Gen::EfectoRespuestafor.create(
                  efecto_id: efecto.id,
                  respuestafor_id: rf.id,
                )
              else # aw.count == 1
                r = aw.take
                er = Cor1440Gen::EfectoRespuestafor.where(
                  efecto_id: efecto.id,
                  respuestafor_id: r.id,
                ).take
              end
              Mr519Gen::ApplicationHelper.asegura_camposdinamicos(
                er, current_usuario_id
              )
            end

            er = if vfid.count > 0
              Cor1440Gen::EfectoRespuestafor
                .where(efecto_id: efecto.id)
                .joins(:respuestafor)
                .where("formulario_id NOT IN (#{vfid.join(", ")})")
            else # vfid.count == 0
              Cor1440Gen::EfectoRespuestafor
                .where(efecto_id: efecto.id)
            end
            if er.count > 0
              rb = er.map(&:respuestafor_id)
              Cor1440Gen::EfectoRespuestafor.connection
                .execute("DELETE FROM cor1440_gen_efecto_respuestafor
                        WHERE efecto_id=#{efecto.id}
                        AND respuestafor_id IN (#{rb.join(", ")})")
              Mr519Gen::Respuestafor.where(id: rb).destroy_all
            end
          end

          def edit_cor1440_gen
            authorize!(:edit, Cor1440Gen::Efecto)
            @registro = @efecto = Cor1440Gen::Efecto.find(params[:id])
            if @registro.registradopor_id.nil?
              @registro.registradopor_id = current_usuario.id
              @registro.save!(validate: false)
            end
            if params["indicadorpf_id"] && params["indicadorpf_id"].to_i > 0
              @registro.indicadorpf_id = params["indicadorpf_id"].to_i
            end
            asegura_camposdinamicos(@registro, current_usuario.id)
            render(layout: "application")
          end

          def edit
            edit_cor1440_gen
          end

          def destroy(mens = "", verifica_tablas_union = true)
            @registro.anexo_efecto = []
            @registro.orgsocial = []
            destroy_gen(mens, verifica_tablas_union)
          end

          def index_reordenar(registros)
            registros.reorder(fecha: :desc, indicadorpf_id: :asc)
          end

          def new_modelo_path(o)
            new_efecto_path
          end

          def genclase
            "M"
          end

          private

          def set_efecto
            @registro = @efecto = Cor1440Gen::Efecto.find(params[:id].to_i)
          end

          def lista_params_cor1440_gen
            atributos_form + [:id] - [:anexo_efecto] + [
              anexo_efecto_attributes: [
                :id,
                :efecto_id,
                :_destroy,
                anexo_attributes: [
                  :id, :descripcion, :adjunto, :_destroy,
                ],
              ],
              respuestafor_attributes: [
                :id,
                "valorcampo_attributes" => [
                  :valor,
                  :campo_id,
                  :id,
                ] +
                  [valor_ids: []],
              ],
            ]
          end

          def lista_params
            lista_params_cor1440_gen
          end

          # No confiar parametros a Internet, sólo permitir lista blanca
          def efecto_params
            params.require(:efecto).permit(lista_params)
          end
        end # included
      end
    end
  end
end
