# encoding: UTF-8
require 'rails_helper'

module Cor440Gen
  RSpec.describe Aslegal, :type => :model do

    it "valido" do
      aslegal = FactoryGirl.build(:cor440_gen_aslegal)
      expect(aslegal).to be_valid
      aslegal.destroy
    end

    it "no valido" do
      aslegal = FactoryGirl.build(:cor440_gen_aslegal, nombre: '')
      expect(aslegal).not_to be_valid
      aslegal.destroy
    end

    it "existente" do
      aslegal = Cor440Gen::Aslegal.where(id: 0).take
      expect(aslegal.nombre).to eq("SIN INFORMACIÓN")
    end

  end
end
