require 'test_helper'

module Cor1440Gen
  class DatointermediotiTest < ActiveSupport::TestCase
    setup do
      Rails.application.config.x.formato_fecha = 'yyyy-mm-dd'
    end

    test "valido" do
      pf = Proyectofinanciero.create PRUEBA_PROYECTOFINANCIERO
      assert pf.valid?
      o = Objetivopf.create PRUEBA_OBJETIVOPF
      assert o.valid?
      r = Resultadopf.create PRUEBA_RESULTADOPF
      assert r.valid?
      i = Indicadorpf.create PRUEBA_INDICADORPF
      assert i.valid?
      mindicadorpf = Mindicadorpf.create PRUEBA_MINDICADORPF
      assert mindicadorpf.valid?

      datointermedioti = Datointermedioti.create PRUEBA_DATOINTERMEDIOTI
      assert datointermedioti.valid?
      datointermedioti.destroy

      mindicadorpf.destroy
      i.destroy
      r.destroy
      o.destroy
      pf.destroy
    end

    test "no valido" do
      i = Cor1440Gen::Datointermedioti.new PRUEBA_DATOINTERMEDIOTI
      assert_not i.valid?
      i.destroy
    end

  end
end
