require_relative '../../test_helper'

module Cor1440Gen
  class ActividadareaTest < ActiveSupport::TestCase

    setup do
      Rails.application.config.x.formato_fecha = 'yyyy-mm-dd'
    end

    test "valido" do
      a = Actividadarea.create PRUEBA_ACTIVIDADAREA
      assert a.valid?
      a.destroy
    end

    test "no valido" do
      a = Actividadarea.new PRUEBA_ACTIVIDADAREA
      a.nombre = ''
      assert_not a.valid?
      a.destroy
    end

    test "existente" do
      a = Cor1440Gen::Actividadarea.where(id: 9).take
      assert_equal 'VOLUNTARIADO', a.nombre
    end
  end
end
