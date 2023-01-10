require 'test_helper'

module Cor1440Gen
  class ActividadAnexoTest < ActiveSupport::TestCase
    setup do
      Rails.application.config.x.formato_fecha = 'yyyy-mm-dd'
    end

    test "valido" do
      anexo = Msip::Anexo.new(PRUEBA_ANEXO)
      anexo.adjunto = File.new(Rails.root + "db/seeds.rb")
      assert anexo.valid?
      anexo.save
      a = Cor1440Gen::Actividad.create PRUEBA_ACTIVIDAD
      assert a.valid?

      aan= Cor1440Gen::ActividadAnexo.create(
        actividad_id: a.id,
        anexo_id: anexo.id
      )
      assert aan.valid?

      a.destroy
      anexo.destroy
    end

    test "no valido" do
      aan = Cor1440Gen::ActividadAnexo.create()
      assert_not aan.valid?
    end

  end
end
