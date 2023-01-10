# frozen_string_literal: true

require "test_helper"

module Cor1440Gen
  class ActividadUsuarioTest < ActiveSupport::TestCase
    setup do
      Rails.application.config.x.formato_fecha = "yyyy-mm-dd"
    end

    test "valido" do
      u = ::Usuario.create(PRUEBA_USUARIO)

      assert_predicate u, :valid?
      a = Cor1440Gen::Actividad.create(PRUEBA_ACTIVIDAD)

      assert_predicate a, :valid?

      au = Cor1440Gen::ActividadUsuario.create(
        actividad_id: a.id,
        usuario_id: u.id,
      )

      assert_predicate au, :valid?

      # ar.destroy  # Sin llave primaria no destruye, pero se destruye con
      # a.destroy
      a.destroy
      u.destroy
    end

    test "no valido" do
      ar = Cor1440Gen::ActividadUsuario.create

      assert_not ar.valid?
    end
  end
end
