# encoding: UTF-8
require 'rails_helper'

module Cor440Gen
  RSpec.describe Rolfamilia, :type => :model do

    it "valido" do
      rolfamilia = FactoryGirl.build(:cor440_gen_rolfamilia)
      expect(rolfamilia).to be_valid
      rolfamilia.destroy
    end

    it "no valido" do
      rolfamilia = FactoryGirl.build(:cor440_gen_rolfamilia, nombre: '')
      expect(rolfamilia).not_to be_valid
      rolfamilia.destroy
    end

    it "existente" do
      rolfamilia = Rolfamilia.where(id: 0).take
      expect(rolfamilia.nombre).to eq("SIN INFORMACIÓN")
    end

  end
end
