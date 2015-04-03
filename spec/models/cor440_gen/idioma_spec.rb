# encoding: UTF-8
require 'rails_helper'

module Cor440Gen
  RSpec.describe Idioma, :type => :model do

    it "valido" do
      idioma = FactoryGirl.build(:cor440_gen_idioma)
      expect(idioma).to be_valid
      idioma.destroy
    end

    it "no valido" do
      idioma = FactoryGirl.build(:cor440_gen_idioma, nombre: '')
      expect(idioma).not_to be_valid
      idioma.destroy
    end

    it "existente" do
      idioma = Idioma.where(id: 0).take
      expect(idioma.nombre).to eq("SIN INFORMACIÓN")
    end

  end
end
