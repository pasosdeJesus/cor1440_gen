module Cor1440Gen
  module Concerns
    module Controllers
      module CampostindController
        extend ActiveSupport::Concern

        included do


          # GET /campotinds/new
          def new
            if params[:tipoindicador_id]
              @campotind = Campotind.new
              @campotind.tipoindicador_id = params[:tipoindicador_id]
              @campotind.nombrecampo = "N"
              if @campotind.save(validate: false)
                respond_to do |format|
                  format.js { render text: @campotind.id.to_s }
                  format.json { render json: @campotind.id.to_s, status: :created }
                  format.html { render inline: 'No implementado', 
                                status: :unprocessable_entity }
                end
              else
                render inline: 'No implementado', status: :unprocessable_entity 
              end
            else
              render inline: 'Falta id de tipoindicador', 
                status: :unprocessable_entity 
            end
          end

          def destroy
            if params[:id]
              @campotind = Campotind.find(params[:id])
              @campotind.destroy
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

