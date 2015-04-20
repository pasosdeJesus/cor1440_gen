# encoding: UTF-8
require 'rails_helper'

module Cor1440Gen
  RSpec.describe Proyectofinanciero, :type => :model do

    it "valido" do
      proyectofinanciero = FactoryGirl.build(:cor1440_gen_proyectofinanciero)
      expect(proyectofinanciero).to be_valid
      proyectofinanciero.destroy
    end

    it "no valido" do
      proyectofinanciero = 
        FactoryGirl.build(:cor1440_gen_proyectofinanciero, nombre: '')
      expect(proyectofinanciero).not_to be_valid
      proyectofinanciero.destroy
    end

  end
end
