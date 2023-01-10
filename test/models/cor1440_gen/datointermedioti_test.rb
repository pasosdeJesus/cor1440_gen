require 'test_helper'

module Cor1440Gen
  class DatointermediotiTest < ActiveSupport::TestCase
    setup do
      Rails.application.config.x.formato_fecha = 'yyyy-mm-dd'
    end

    test "valido" do
      pf = Proyectofinanciero.create PRUEBA_PROYECTOFINANCIERO
      assert pf.valid?
      o = Objetivopf.create PRUEBA_OBJETIVOPF.merge(
        proyectofinanciero_id: pf.id
      )
      puts "OJO o=#{o.inspect} #{o.valid?} #{o.errors}"
      assert o.valid?
      r = Resultadopf.create PRUEBA_RESULTADOPF.merge(
        proyectofinanciero_id: pf.id
      )

      assert r.valid?
      i = Indicadorpf.create PRUEBA_INDICADORPF.merge(
        proyectofinanciero_id: pf.id
      )

      assert i.valid?
      mindicadorpf = Mindicadorpf.create PRUEBA_MINDICADORPF.merge(
        proyectofinanciero_id: pf.id
      )

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
