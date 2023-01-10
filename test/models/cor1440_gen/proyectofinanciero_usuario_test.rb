require 'test_helper'

module Cor1440Gen
  class ProyectofinancieroUsuarioTest < ActiveSupport::TestCase
    setup do
      Rails.application.config.x.formato_fecha = 'yyyy-mm-dd'
    end

    test "valido" do
      usuario = ::Usuario.create PRUEBA_USUARIO
      assert usuario.valid?
      proyectofinanciero = Cor1440Gen::Proyectofinanciero.create(
        PRUEBA_PROYECTOFINANCIERO
      )
      assert proyectofinanciero.valid?

      pu = Cor1440Gen::ProyectofinancieroUsuario.create(
        proyectofinanciero_id: proyectofinanciero.id,
        usuario_id: usuario.id
      )
      assert pu.valid?

      #pu.destroy  # Sin llave primaria no destruye, pero se destruye con pf
      proyectofinanciero.destroy
      usuario.destroy
    end

    test "no valido" do
      proyectofinanciero = Cor1440Gen::ProyectofinancieroUsuario.create()
      assert_not proyectofinanciero.valid?
    end

  end
end
