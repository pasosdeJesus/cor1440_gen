# frozen_string_literal: true

module Cor1440Gen
  module Concerns
    module Controllers
      module IndicadorespfController
        extend ActiveSupport::Concern

        included do
          # GET /indicadorpf/new
          def new
            if params[:proyectofinanciero_id]
              @indicadorpf = Indicadorpf.new
              @indicadorpf.proyectofinanciero_id = params[:proyectofinanciero_id]
              @indicadorpf.numero = "R"
              @indicadorpf.indicador = "R"
              if @indicadorpf.save(validate: false)
                respond_to do |format|
                  format.js { render(text: @indicadorpf.id.to_s) }
                  format.json { render(json: @indicadorpf.id.to_s, status: :created) }
                  format.html do
                    render(
                      inline: "No implementado",
                      status: :unprocessable_entity,
                    )
                  end
                end
              else
                render(
                  inline: "No implementado",
                  status: :unprocessable_entity,
                )
              end
            else
              render(
                inline: "Falta id de proyectofinanciero",
                status: :unprocessable_entity,
              )
            end
          end

          def destroy
            if params[:id]
              if Indicadorpf.where(id: params[:id]).count > 0
                @indicadorpf = Indicadorpf.find(params[:id])
                @indicadorpf.destroy
              end
              respond_to do |format|
                format.html do
                  render(
                    inline: "Not implemented",
                    status: :unprocessable_entity,
                  )
                end
                format.json { head(:no_content) }
              end
            end
          end
        end # included
      end
    end
  end
end
