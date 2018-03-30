# encoding: UTF-8

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
              @indicadorpf.numero= "R"
              @indicadorpf.indicador= "R"
              if @indicadorpf.save(validate: false)
                respond_to do |format|
                  format.js { render text: @indicadorpf.id.to_s }
                  format.json { render json: @indicadorpf.id.to_s, status: :created }
                  format.html { render inline: 'No implementado', 
                                status: :unprocessable_entity }
                end
              else
                render inline: 'No implementado', 
                  status: :unprocessable_entity 
              end
            else
              render inline: 'Falta id de proyectofinanciero', 
                status: :unprocessable_entity 
            end
          end

          def destroy
            if params[:id]
              @indicadorpf = Indicadorpf.find(params[:id])
              @indicadorpf.destroy
              respond_to do |format|
                format.html { render inline: 'Not implemented', 
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

