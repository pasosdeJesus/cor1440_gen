require_relative '../../test_helper'

module Cor1440Gen
  class ObjetivopfTest < ActiveSupport::TestCase

    setup do
      Rails.application.config.x.formato_fecha = 'yyyy-mm-dd'
    end

    test "valido" do
      pf = Proyectofinanciero.create PRUEBA_PROYECTOFINANCIERO
      assert pf.valid?
      o = Objetivopf.create PRUEBA_OBJETIVOPF
      assert o.valid?
      o.destroy
      pf.destroy
    end

    test "no valido" do
      o = Objetivopf.new PRUEBA_OBJETIVOPF
      o.objetivo=""
      assert_not o.valid?
      o.destroy
    end

  end
end
