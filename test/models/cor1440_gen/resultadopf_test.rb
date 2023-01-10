# frozen_string_literal: true

require_relative "../../test_helper"

module Cor1440Gen
  class ResultadopfTest < ActiveSupport::TestCase
    setup do
      Rails.application.config.x.formato_fecha = "yyyy-mm-dd"
    end

    test "valido" do
      pf = Proyectofinanciero.create(PRUEBA_PROYECTOFINANCIERO)

      assert_predicate pf, :valid?
      o = Objetivopf.create(PRUEBA_OBJETIVOPF.merge(
        proyectofinanciero_id: pf.id,
      ))

      assert_predicate o, :valid?
      r = Resultadopf.create(PRUEBA_RESULTADOPF.merge(
        proyectofinanciero_id: pf.id,
      ))

      assert_predicate r, :valid?
      r.destroy
      o.destroy
      pf.destroy
    end

    test "no valido" do
      r = Resultadopf.new(PRUEBA_RESULTADOPF)
      r.resultado = ""

      assert_not r.valid?
      r.destroy
    end
  end
end
