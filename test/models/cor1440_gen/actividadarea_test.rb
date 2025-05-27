# frozen_string_literal: true

require_relative "../../test_helper"

module Cor1440Gen
  class ActividadareaTest < ActiveSupport::TestCase
    setup do
      Rails.application.config.x.formato_fecha = "yyyy-mm-dd"
    end

    test "valido" do
      a = Actividadarea.create(PRUEBA_ACTIVIDADAREA)

      assert_predicate a, :valid?
      a.destroy
    end

    test "no valido" do
      a = Actividadarea.new(PRUEBA_ACTIVIDADAREA)
      a.nombre = ""

      assert_not a.valid?
      a.destroy
    end

    test "existente" do
      a = Cor1440Gen::Actividadarea.find_by(id: 9)

      assert_equal "VOLUNTARIADO", a.nombre
    end
  end
end
