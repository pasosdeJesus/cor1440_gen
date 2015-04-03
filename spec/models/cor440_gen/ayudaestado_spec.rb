# encoding: UTF-8
require 'rails_helper'

module Cor440Gen
  RSpec.describe Ayudaestado, :type => :model do

    it "valido" do
      ayudaestado = FactoryGirl.build(:cor440_gen_ayudaestado)
      expect(ayudaestado).to be_valid
      ayudaestado.destroy
    end

    it "no valido" do
      ayudaestado = FactoryGirl.build(:cor440_gen_ayudaestado, nombre: '')
      expect(ayudaestado).not_to be_valid
      ayudaestado.destroy
    end

    it "existente" do
      ayudaestado = Ayudaestado.where(id: 0).take
      expect(ayudaestado.nombre).to eq("SIN INFORMACIÓN")
    end

  end
end
