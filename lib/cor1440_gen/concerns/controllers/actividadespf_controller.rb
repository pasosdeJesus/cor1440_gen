module Cor1440Gen
  module Concerns
    module Controllers
      module ActividadespfController 
        extend ActiveSupport::Concern

        included do


          # GET /actividadpf/new
          def new
            if params[:proyectofinanciero_id]
              @actividadpf = Actividadpf.new
              @actividadpf.proyectofinanciero_id = params[:proyectofinanciero_id]
              @actividadpf.nombrecorto = "R"
              @actividadpf.titulo = "R"
              if @actividadpf.save(validate: false)
                respond_to do |format|
                  format.js { render text: @actividadpf.id.to_s }
                  format.json { render json: @actividadpf.id.to_s, status: :created }
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
              @actividadpf = Actividadpf.find(params[:id])
              @actividadpf.destroy
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

