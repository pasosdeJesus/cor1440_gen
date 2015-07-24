# encoding: UTF-8
require 'rails_helper'
module Cor1440Gen
  RSpec.describe Actividadarea, :type => :model do

    it "valido" do
      actividadarea = FactoryGirl.build(:cor1440_gen_actividadarea)
      expect(actividadarea).to be_valid
      actividadarea.destroy
    end

    it "no valido" do
      actividadarea = FactoryGirl.build(:cor1440_gen_actividadarea, nombre: '')
      expect(actividadarea).not_to be_valid
      actividadarea.destroy
    end

    it "existente" do
      actividadarea = Cor1440Gen::Actividadarea.where(id: 9).take
      expect(actividadarea.nombre).to eq("VOLUNTARIADO")
    end
  end
end
