# frozen_string_literal: true

require_relative "../../test_helper"

module Cor1440Gen
  class ProyectofinancieroTest < ActiveSupport::TestCase
    setup do
      Rails.application.config.x.formato_fecha = "yyyy-mm-dd"
    end

    test "valido" do
      pf = Proyectofinanciero.create(PRUEBA_PROYECTOFINANCIERO)

      assert_predicate pf, :valid?
      pf.destroy
    end

    test "no valido" do
      pf = Proyectofinanciero.new(PRUEBA_PROYECTOFINANCIERO)
      pf.nombre = ""

      assert_not pf.valid?
      pf.destroy
    end
  end
end
