# frozen_string_literal: true

module Cor1440Gen
  module Concerns
    module Controllers
      module ActividadespfController
        extend ActiveSupport::Concern

        included do
          # Completa una lista de actividadespf con otras de las
          # cuales heredan, limitadas a un listado de proyectospf
          def conancestros
            prob = ""
            actividadpf_ids = []
            proyectofinanciero_ids = []
            if params[:proyectofinanciero_ids]
              proyectofinanciero_ids = params[:proyectofinanciero_ids]
            end
            if params[:actividadpf_ids]
              params[:actividadpf_ids].reject(&:empty?).each do |acpf_id|
                next unless !actividadpf_ids.include?(acpf_id.to_i) &&
                  Cor1440Gen::Actividadpf.where(id: acpf_id.to_i).count == 1

                hd_id = acpf_id.to_i
                actividadpf_ids |= [hd_id]
                until Cor1440Gen::Actividadpf.find(hd_id).heredade_id.nil?
                  hd_id = Cor1440Gen::Actividadpf.find(hd_id).heredade_id
                  next unless !actividadpf_ids.include?(hd_id) &&
                    Cor1440Gen::Actividadpf.where(id: hd_id)
                      .where(proyectofinanciero_id: proyectofinanciero_ids)
                      .count == 1

                  actividadpf_ids |= [hd_id]
                end
              end
              respond_to do |format|
                format.json do
                  render(
                    json: {
                      ac_ids_conancestros: actividadpf_ids,
                    },
                    status: :ok,
                  )
                  return
                end
              end
            else
              prob = "No es posible completar ancestros"
            end
            respond_to do |format|
              format.html { render(action: "error") }
              format.json do
                render(
                  json: prob,
                  status: :unprocessable_entity,
                )
              end
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
                  format.js { render(text: @actividadpf.id.to_s) }
                  format.json { render(json: @actividadpf.id.to_s, status: :created) }
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
              @actividadpf = Actividadpf.find(params[:id])
              @actividadpf.destroy
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
          # Retorna ids de actividadespf que el usuario actual puede leer con
          # las restricciones del filtro:
          #   filtro[:proyectofinanciero_ids] limita a los proyectos
          #   financieros con las ids dadas
          def disponibles_cor1440_gen(filtro, ability, c = nil)
            c2 = c ? c : Cor1440Gen::Actividadpf.accessible_by(ability)
            if filtro[:proyectofinanciero_ids] &&
                filtro[:proyectofinanciero_ids].count > 0
              pf_ids = filtro[:proyectofinanciero_ids].map(&:to_i)
              c2 = c2.where(
                "cor1440_gen_actividadpf.proyectofinanciero_id IN (?)",
                pf_ids,
              )
            end
            c2
          end

          def disponibles(filtro, ability, c = nil)
            disponibles_cor1440_gen(filtro, ability, c)
          end
        end # class_methods
      end
    end
  end
end
