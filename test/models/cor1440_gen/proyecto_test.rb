# frozen_string_literal: true

require_relative "../../test_helper"

module Cor1440Gen
  class ProyectoTest < ActiveSupport::TestCase
    PRUEBA_PROYECTO = {
      id: 1000,
      nombre: "Proyecto",
      fechacreacion: "2015-04-20",
      created_at: "2015-04-20",
    }

    setup do
      Rails.application.config.x.formato_fecha = "yyyy-mm-dd"
    end

    test "valido" do
      p = Proyecto.create(PRUEBA_PROYECTO)

      assert_predicate p, :valid?
      p.destroy
    end

    test "no valido" do
      p = Proyecto.new(PRUEBA_PROYECTO)
      p.nombre = ""

      assert_not p.valid?
      p.destroy
    end
  end
end
