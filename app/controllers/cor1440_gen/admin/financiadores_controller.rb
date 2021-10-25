require_dependency "cor1440_gen/concerns/controllers/financiadores_controller"

module Cor1440Gen
  module Admin
    class FinanciadoresController < Sip::Admin::BasicasController
      include Cor1440Gen::Concerns::Controllers::FinanciadoresController
        before_action :set_financiador, 
          only: [:show, :edit, :update, :destroy]
        load_and_authorize_resource  class: Cor1440Gen::Financiador
    end
  end
end
