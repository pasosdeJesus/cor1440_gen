require 'test_helper'

module Cor1440Gen
  class RangoedadactTest < ActiveSupport::TestCase

    setup do
      Rails.application.config.x.formato_fecha = 'yyyy-mm-dd'
    end

    test "valido" do
      rangoedadac = Rangoedadac.create PRUEBA_RANGOEDADAC
      assert rangoedadac.valid?
      rangoedadac.destroy
    end

    test "no valido" do
      rangoedadac = Rangoedadac.new PRUEBA_RANGOEDADAC
      rangoedadac.nombre =""
      assert_not rangoedadac.valid?
      rangoedadac.destroy
    end

    test "existente" do
      rangoedadac = Cor1440Gen::Rangoedadac.where(id: 6).take
      assert_equal 'De 61 en adelante', rangoedadac.nombre
    end

  end
end
