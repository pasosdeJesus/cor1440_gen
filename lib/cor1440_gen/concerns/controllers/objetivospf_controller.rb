# frozen_string_literal: true

module Cor1440Gen
  module Concerns
    module Controllers
      module ObjetivospfController
        extend ActiveSupport::Concern

        included do
          # GET /objetivopfs/new
          def new
            if params[:proyectofinanciero_id]
              @objetivopf = Objetivopf.new
              @objetivopf.proyectofinanciero_id = params[:proyectofinanciero_id]
              @objetivopf.numero = "O"
              @objetivopf.objetivo = "O"
              if @objetivopf.save(validate: false)
                respond_to do |format|
                  format.js { render(text: @objetivopf.id.to_s) }
                  format.json { render(json: @objetivopf.id.to_s, status: :created) }
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
                inline: "Falta id de proyectofinanciero",
                status: :unprocessable_entity,
              )
            end
          end

          def destroy
            if params[:id]
              @objetivopf = Objetivopf.find(params[:id])
              @objetivopf.destroy
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
      end
    end
  end
end
