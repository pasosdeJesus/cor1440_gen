# frozen_string_literal: true

require_relative "../../test_helper"

module Msip
  class OrgsocialTest < ActiveSupport::TestCase
    test "valido" do
      grupoper = Msip::Grupoper.create(PRUEBA_GRUPOPER)

      assert_predicate grupoper, :valid?
      grupoper.save!
      orgsocial = Msip::Orgsocial.new(PRUEBA_ORGSOCIAL)
      orgsocial.grupoper = grupoper

      assert_predicate orgsocial, :valid?
      orgsocial.save!
      orgsocial.destroy
      grupoper.destroy
    end

    test "no valido" do
      orgsocial = Msip::Orgsocial.new(PRUEBA_ORGSOCIAL)
      orgsocial.grupoper = nil

      assert_not_predicate orgsocial, :valid?
      orgsocial.destroy
    end
  end
end
