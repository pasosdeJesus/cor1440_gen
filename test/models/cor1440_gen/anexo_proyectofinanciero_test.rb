# frozen_string_literal: true

require "test_helper"

module Cor1440Gen
  class AnexoProyectofinancieroAnexoTest < ActiveSupport::TestCase
    setup do
      Rails.application.config.x.formato_fecha = "yyyy-mm-dd"
    end

    test "valido" do
      anexo = Msip::Anexo.new(PRUEBA_ANEXO)
      anexo.adjunto = File.new(Rails.root + "db/seeds.rb")

      assert_predicate anexo, :valid?
      anexo.save

      pf = Proyectofinanciero.create(PRUEBA_PROYECTOFINANCIERO)

      assert_predicate pf, :valid?

      ap = Cor1440Gen::AnexoProyectofinanciero.create(
        proyectofinanciero_id: pf.id,
        anexo_id: anexo.id,
      )

      assert_predicate ap, :valid?

      pf.destroy
      anexo.destroy
    end

    test "no valido" do
      ap = Cor1440Gen::AnexoProyectofinanciero.create

      assert_not ap.valid?
    end
  end
end
