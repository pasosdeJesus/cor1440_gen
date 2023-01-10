# frozen_string_literal: true

require "test_helper"

module Cor1440Gen
  class EfectoTest < ActiveSupport::TestCase
    setup do
      Rails.application.config.x.formato_fecha = "yyyy-mm-dd"
    end

    test "valido" do
      grupoper = Msip::Grupoper.create(PRUEBA_GRUPOPER)

      assert_predicate grupoper, :valid?
      grupoper.save!
      orgsocial = Msip::Orgsocial.create(PRUEBA_ORGSOCIAL.merge(
        grupoper_id: grupoper.id,
      ))

      assert_predicate orgsocial, :valid?

      anexo = Msip::Anexo.new(PRUEBA_ANEXO)
      anexo.adjunto = File.new(Rails.root + "db/seeds.rb")

      assert_predicate anexo, :valid?
      anexo.save

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
      i = Indicadorpf.create(PRUEBA_INDICADORPF.merge(
        proyectofinanciero_id: pf.id,
      ))

      assert_predicate i, :valid?
      u = ::Usuario.create(PRUEBA_USUARIO)

      assert_predicate u, :valid?

      e = Efecto.new(PRUEBA_EFECTO)
      e.save(validate: false)
      eo = EfectoOrgsocial.create(
        efecto_id: e.id,
        orgsocial_id: orgsocial.id,
      )
      assert_predicate eo, :valid?
      ea = AnexoEfecto.create(
        efecto_id: e.id,
        anexo_id: anexo.id,
      )
      assert_predicate ea, :valid?
      e.destroy
      u.destroy
      i.destroy
      r.destroy
      o.destroy
      pf.destroy
      anexo.destroy
      orgsocial.destroy
      grupoper.destroy
    end

    test "no valido" do
      e = Cor1440Gen::Efecto.new(PRUEBA_EFECTO.merge(
        nombre: nil,
      ))

      assert_not e.valid?
    end
  end
end
