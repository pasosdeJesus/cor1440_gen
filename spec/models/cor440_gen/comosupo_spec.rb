# encoding: UTF-8
require 'rails_helper'

module Cor440Gen
  RSpec.describe Comosupo, :type => :model do

    it "valido" do
      comosupo = FactoryGirl.build(:cor440_gen_comosupo)
      expect(comosupo).to be_valid
      comosupo.destroy
    end

    it "no valido" do
      comosupo = FactoryGirl.build(:cor440_gen_comosupo, nombre: '')
      expect(comosupo).not_to be_valid
      comosupo.destroy
    end

    it "existente" do
      comosupo = Comosupo.where(id: 1).take
      expect(comosupo.nombre).to eq("SIN INFORMACIÓN")
    end

  end
end
