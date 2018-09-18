# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Controllers
      module CamposactController
        extend ActiveSupport::Concern

        included do


          # GET /campoacts/new
          def new
            if params[:actividadtipo_id] 
              @campoact = Campoact.new
              @campoact.actividadtipo_id = params[:actividadtipo_id]
              @campoact.nombrecampo = "N"
              if @campoact.save(validate: false)
                respond_to do |format|
                  format.js { render text: @campoact.id.to_s }
                  format.json { render json: @campoact.id.to_s, 
                                status: :created }
                  format.html { render inline: 'No implementado', 
                                status: :unprocessable_entity }
                end
              else
                render inline: 'No implementado', status: :unprocessable_entity 
              end
            else
              render inline: 'Falta id de actividadtipo', 
                status: :unprocessable_entity 
            end
          end

          def destroy
            if params[:id]
              @campoact = Campoact.find(params[:id])
              @campoact.destroy
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

