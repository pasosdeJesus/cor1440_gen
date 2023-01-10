# frozen_string_literal: true

require "test_helper"

module Cor1440Gen
  class ActividadTest < ActiveSupport::TestCase
    setup do
      Rails.application.config.x.formato_fecha = "yyyy-mm-dd"
    end

    test "valido" do
      a = Cor1440Gen::Actividad.create(PRUEBA_ACTIVIDAD)

      assert_predicate a, :valid?
      a.destroy
    end

    test "no valido" do
      a = Cor1440Gen::Actividad.new(PRUEBA_ACTIVIDAD)
      a.oficina_id = nil

      assert_not a.valid?
      a.destroy
    end
  end
end
