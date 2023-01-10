require 'test_helper'

module Cor1440Gen
  class FinanciadorProyectofinancieroTest < ActiveSupport::TestCase
    setup do
      Rails.application.config.x.formato_fecha = 'yyyy-mm-dd'
    end

    test "valido" do
      financiador = Financiador.create(PRUEBA_FINANCIADOR)
      assert financiador.valid?

      pf = Proyectofinanciero.create PRUEBA_PROYECTOFINANCIERO
      assert pf.valid?

      fp = Cor1440Gen::FinanciadorProyectofinanciero.create(
        proyectofinanciero_id: pf.id,
        financiador_id: financiador.id
      )
      assert fp.valid?

      pf.destroy
      financiador.destroy
    end

    test "no valido" do
      ap = Cor1440Gen::FinanciadorProyectofinanciero.create()
      assert_not ap.valid?
    end

  end
end
