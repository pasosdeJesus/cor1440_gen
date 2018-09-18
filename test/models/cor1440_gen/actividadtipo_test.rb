# encoding: UTF-8

require_relative '../../test_helper'

module Cor1440Gen
  class ActividadtipoTest < ActiveSupport::TestCase

    PRUEBA_ACTIVIDADTIPO={
      id: 1000,
      nombre: "Cor1440_gen_actividadtipo",
      fechacreacion: "2015-04-20",
      created_at: "2015-04-20"
    }


    setup do
      Rails.application.config.x.formato_fecha = 'yyyy-mm-dd'
    end

    test "valido" do
      at = Actividadtipo.create PRUEBA_ACTIVIDADTIPO
      assert at.valid?
      at.destroy
    end

    test "no valido" do
      at = Actividadtipo.new PRUEBA_ACTIVIDADTIPO
      at.nombre=''
      assert_not at.valid?
      at.destroy
    end

  end
end
