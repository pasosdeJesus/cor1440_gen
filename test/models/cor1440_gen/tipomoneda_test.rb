require_relative '../../test_helper'

module Cor1440Gen
  class Cor1440GenTipomonedaTest < ActiveSupport::TestCase
  
    PRUEBA_TIPOMONEDA={
      id: 1000 ,
      nombre: "Cor1440_gen_tipomoneda",
      pais_id: 170,
      simbolo: 'x',
      codiso4217: 'x',
      fechacreacion: "2015-04-20",
      created_at: "2015-04-20"
    } 

    setup do
      Rails.application.config.x.formato_fecha = 'yyyy-mm-dd'
    end

    test "valido" do
      f = Tipomoneda.create PRUEBA_TIPOMONEDA
      assert f.valid?
      f.destroy
    end

    test "no valido" do
      f = Tipomoneda.new PRUEBA_TIPOMONEDA
      f.nombre=''
      assert_not f.valid?
      f.destroy
    end

  end
end
