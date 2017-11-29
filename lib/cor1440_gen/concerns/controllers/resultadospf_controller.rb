# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Controllers
      module ResultadospfController
        extend ActiveSupport::Concern

        included do

          # GET /resultadopfs/new
          def new
            if params[:proyectofinanciero_id]
              @resultadopf = Resultadopf.new
              @resultadopf.proyectofinanciero_id = params[:proyectofinanciero_id]
              @resultadopf.numero= "R"
              @resultadopf.resultado= "R"
              if @resultadopf.save(validate: false)
                respond_to do |format|
                  format.js { render text: @resultadopf.id.to_s }
                  format.json { render json: @resultadopf.id.to_s, status: :created }
                  format.html { render inline: 'No implementado', 
                                status: :unprocessable_entity }
                end
              else
                render inline: 'No implementado', status: :unprocessable_entity 
              end
            else
              render inline: 'Falta id de proyectofinanciero', 
                status: :unprocessable_entity 
            end
          end

          def destroy
            if params[:id]
              @resultadopf = Resultadopf.find(params[:id])
              @resultadopf.destroy
              respond_to do |format|
                format.html { render inline: 'No implementado', 
                              status: :unprocessable_entity }
                format.json { head :no_content }
              end
            end
          end

        end #included

      end
    end
  end
end

