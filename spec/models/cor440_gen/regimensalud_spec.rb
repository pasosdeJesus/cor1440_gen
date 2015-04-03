# encoding: UTF-8
require 'rails_helper'

module Cor440Gen
  RSpec.describe Regimensalud, :type => :model do

    it "valido" do
      regimensalud = FactoryGirl.build(:cor440_gen_regimensalud)
      expect(regimensalud).to be_valid
      regimensalud.destroy
    end

    it "no valido" do
      regimensalud = FactoryGirl.build(:cor440_gen_regimensalud, nombre: '')
      expect(regimensalud).not_to be_valid
      regimensalud.destroy
    end

    it "existente" do
      regimensalud = Regimensalud.where(id: 0).take
      expect(regimensalud.nombre).to eq("SIN INFORMACIÓN")
    end

  end
end
