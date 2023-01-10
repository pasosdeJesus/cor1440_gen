require 'test_helper'

module Cor1440Gen
  class CaracterizacionpfTest < ActiveSupport::TestCase
    setup do
      Rails.application.config.x.formato_fecha = 'yyyy-mm-dd'
    end

    test "valido" do
      f = ::Mr519Gen::Formulario.create(PRUEBA_FORMULARIO)
      assert f.valid?
      p = Proyectofinanciero.create PRUEBA_PROYECTOFINANCIERO
      assert p.valid?

      cp = Cor1440Gen::Caracterizacionpf.create(
        formulario_id: f.id,
        proyectofinanciero_id: p.id,
      )
      assert cp.valid?

      p.destroy
      f.destroy
    end

    test "no valido" do
      cp = Cor1440Gen::Caracterizacionpf.create()
      assert_not cp.valid?
    end

  end
end
