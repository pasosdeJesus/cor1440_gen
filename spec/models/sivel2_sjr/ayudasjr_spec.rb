# encoding: UTF-8
require 'rails_helper'

module Sivel2Sjr
  RSpec.describe Ayudasjr, :type => :model do

    it "valido" do
      ayudasjr = FactoryGirl.build(:sivel2_sjr_ayudasjr)
      expect(ayudasjr).to be_valid
      ayudasjr.destroy
    end

    it "no valido" do
      ayudasjr = FactoryGirl.build(:sivel2_sjr_ayudasjr, nombre: '')
      expect(ayudasjr).not_to be_valid
      ayudasjr.destroy
    end

    it "existente" do
      ayudasjr = Ayudasjr.where(id: 0).take
      expect(ayudasjr.nombre).to eq("SIN INFORMACIÓN")
    end

  end
end
