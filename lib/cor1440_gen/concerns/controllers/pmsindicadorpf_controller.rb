# frozen_string_literal: true

module Cor1440Gen
  module Concerns
    module Controllers
      module PmsindicadorpfController
        extend ActiveSupport::Concern

        included do
          include Msip::FormatoFechaHelper
          helper Msip::FormatoFechaHelper

          def clase
            "Cor1440Gen::Pmsindicadorpf"
          end

          # GET /pmsindicadorpf/new
          def new
            if params[:mindicadorpf_id] && Cor1440Gen::Mindicadorpf.where(id: params[:mindicadorpf_id].to_i).count == 1
              mind = Cor1440Gen::Mindicadorpf.find(params[:mindicadorpf_id].to_i)
              fini = Date.today
              ffin = fini + 1.month
              restiempo = "Mes"
              meta = 1
              @pmindicadorpf = Cor1440Gen::Pmindicadorpf.create(
                mindicadorpf_id: mind.id,
                finicio: fini,
                ffin: ffin,
                restiempo: restiempo,
                meta: meta,
              )
              if @pmindicadorpf.save
                respond_to do |format|
                  format.js { render(text: @pmindicadorpf.id.to_s) }
                  format.json { render(json: @pmindicadorpf.id.to_s, status: :created) }
                  format.html do
                    render(
                      inline: "No implementado",
                      status: :unprocessable_entity,
                    )
                  end
                end
              else
                render(inline: "No implementado", status: :unprocessable_entity)
              end
            else
              render(
                inline: "Faltó identificación de mindicadorpf",
                status: :unprocessable_entity,
              )
            end
          end

          def destroy
            if params[:id]
              @pmindicadorpf = Cor1440Gen::Pmindicadorpf.find(params[:id])
              @pmindicadorpf.destroy
              respond_to do |format|
                format.html do
                  render(
                    inline: "No implementado",
                    status: :unprocessable_entity,
                  )
                end
                format.json { head(:no_content) }
              end
            end
          end
        end # included

        class_methods do
          def crea_pmindicadorpf(mind, fini, ffin, restiempo, meta)
            pm = Cor1440Gen::Pmindicadorpf.create(
              mindicadorpf_id: mind.id,
              finicio: fini,
              ffin: ffin,
              restiempo: restiempo,
              meta: meta,
            )
            pm.save(validate: false)
            if mind.indicadorpf.tipoindicador &&
                mind.indicadorpf.tipoindicador.datointermedioti
              dids = mind.indicadorpf.tipoindicador.datointermedioti
                .map(&:id)
              dids.each do |di|
                dp = Cor1440Gen::DatointermediotiPmindicadorpf.create(
                  pmindicadorpf_id: pm.id,
                  datointermedioti_id: di,
                )
                dp.save(validate: false)
              end
            end
            pm
          end
        end
      end
    end
  end
end
