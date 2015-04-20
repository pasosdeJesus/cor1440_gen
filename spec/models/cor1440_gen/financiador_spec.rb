# encoding: UTF-8
require 'rails_helper'

module Cor1440Gen

  RSpec.describe Financiador, :type => :model do

    it "valido" do
      financiador = FactoryGirl.build(:cor1440_gen_financiador)
      expect(financiador).to be_valid
      financiador.destroy
    end

    it "no valido" do
      financiador = 
        FactoryGirl.build(:cor1440_gen_financiador, nombre: '')
      expect(financiador).not_to be_valid
      financiador.destroy
    end

  end
end
