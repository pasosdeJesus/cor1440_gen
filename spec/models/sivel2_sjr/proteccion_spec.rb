# encoding: UTF-8
require 'rails_helper'

module Sivel2Sjr
  RSpec.describe Proteccion, :type => :model do

    it "valido" do
      proteccion = FactoryGirl.build(:sivel2_sjr_proteccion)
      expect(proteccion).to be_valid
      proteccion.destroy
    end

    it "no valido" do
      proteccion = FactoryGirl.build(:sivel2_sjr_proteccion, nombre: '')
      expect(proteccion).not_to be_valid
      proteccion.destroy
    end

    it "existente" do
      proteccion = Proteccion.where(id: 0).take
      expect(proteccion.nombre).to eq("SIN INFORMACIÓN")
    end

  end
end
