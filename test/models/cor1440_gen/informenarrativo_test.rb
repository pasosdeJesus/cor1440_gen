require 'test_helper'

module Cor1440Gen
  class InformenarrativoTest < ActiveSupport::TestCase
    setup do
      Rails.application.config.x.formato_fecha = 'yyyy-mm-dd'
    end

    test "valido" do
      proyectofinanciero = Cor1440Gen::Proyectofinanciero.create(
        PRUEBA_PROYECTOFINANCIERO
      )
      assert proyectofinanciero.valid?

      i = Cor1440Gen::Informenarrativo.create(
        proyectofinanciero_id: proyectofinanciero.id,
        detalle: 'x',
        fecha: '2023-03-03'
      )
      assert i.valid?

      i.destroy
      proyectofinanciero.destroy
    end

    test "no valido" do
      i = Cor1440Gen::Informenarrativo.create()
      assert_not i.valid?
    end

  end
end
