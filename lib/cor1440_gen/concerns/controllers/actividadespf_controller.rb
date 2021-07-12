module Cor1440Gen
  module Concerns
    module Controllers
      module ActividadespfController 
        extend ActiveSupport::Concern

        included do


          # Completa una lista de actividadespf con otras de las
          # cuales heredan, limitadas a un listado de proyectospf
          def conancestros
            prob = ''
            actividadpf_ids = []
            proyectofinanciero_ids = []
            if params[:proyectofinanciero_ids]
              proyectofinanciero_ids = params[:proyectofinanciero_ids]
            end
            if params[:actividadpf_ids]
              params[:actividadpf_ids].reject(&:empty?).each do |acpf_id|
                if !actividadpf_ids.include?(acpf_id.to_i) &&
                    Cor1440Gen::Actividadpf.where(id: acpf_id.to_i).count == 1
                  hd_id = acpf_id.to_i
                  actividadpf_ids |= [hd_id]
                  while !Cor1440Gen::Actividadpf.find(hd_id).heredade_id.nil?
                    hd_id = Cor1440Gen::Actividadpf.find(hd_id).heredade_id
                    if !actividadpf_ids.include?(hd_id) && 
                        Cor1440Gen::Actividadpf.where(id: hd_id).
                        where(proyectofinanciero_id: proyectofinanciero_ids).
                        count == 1
                      actividadpf_ids |= [hd_id]
                    end
                  end
                end
              end
              respond_to do |format|
                format.json { 
                  render json: {
                    ac_ids_conancestros: actividadpf_ids}, 
                    status: :ok
                    return
                }
              end
            else
              prob = 'No es posible completar ancestros'
            end
            respond_to do |format|
              format.html { render action: "error" }
              format.json { render json: prob, 
                            status: :unprocessable_entity 
              }
            end
          end


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

