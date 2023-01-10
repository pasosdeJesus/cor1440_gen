# frozen_string_literal: true

module Cor1440Gen
  module ApplicationHelper
    include Msip::PaginacionAjaxHelper

    # TIPO_CAMPODIN = [ ['Texto', 1],
    #                  ['Texto largo', 2],
    #                  ['Entero', 3],
    #                  ['Booleano', 4],
    #                  ['Flotante', 5]
    # ]

    # Las letras escogidas para cada estado están en orden para facilitar presentar
    # en ese orden
    ESTADO = [
      ["EN CIERRE", :C], # Necesario para pestana en cierre de Cuadro General Seguimiento
      ["EN TRAMITE", :E],
      ["EN EJECUCIÓN", :J],
      ["APROBADO", :K],
      ["CERRADO O LIQUIDADO", :M], # Antes era TERMINADO cambio solicitado 13.Nov.2018
      ["DESCARTADO", :O],
      ["RECHAZADO", :R],
    ]

    ESTADOS_APROBADO = [:C, :J, :K, :M]

    DIFICULTAD = [
      ["BAJA", :B],
      ["MEDIA", :M],
      ["ALTA", :A],
      ["N/A", :N],
    ]
  end
end
