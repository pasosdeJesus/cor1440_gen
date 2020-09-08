# encoding: UTF-8
require_dependency "cor1440_gen/concerns/controllers/financiadores_controller"

module Cor1440Gen
  module Admin
    class FinanciadoresController < Sip::ModelosController
      include Cor1440Gen::Concerns::Controllers::FinanciadoresController
    end
  end
end
