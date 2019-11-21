# encoding: UTF-8

module Cor1440Gen
  module ApplicationHelper

    include Sip::PaginacionAjaxHelper

    TIPO_CAMPODIN = [ ['Texto', 1],
                      ['Texto largo', 2],
                      ['Entero', 3],
                      ['Booleano', 4],
                      ['Flotante', 5]
    ]
  end
end
