# frozen_string_literal: true

require_relative "../../test_helper"

module Cor1440Gen
  class InformeTest < ActiveSupport::TestCase
    PRUEBA_INFORME = {
      id: 1000,
      titulo: "Informe",
      filtrofechaini: "2014-09-09",
      filtrofechafin: "2014-09-09",
      created_at: "2014-09-09",
      updated_at: "2014-09-09",
    }

    setup do
      Rails.application.config.x.formato_fecha = "yyyy-mm-dd"
    end

    test "valido" do
      i = Informe.create(PRUEBA_INFORME)

      assert_predicate i, :valid?
      i.destroy
    end

    test "no valido" do
      i = Informe.new(PRUEBA_INFORME)
      i.titulo = ""

      assert_not i.valid?
      i.destroy
    end
  end
end
