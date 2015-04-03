# encoding: UTF-8
require 'rails_helper'

module Cor440Gen
  RSpec.describe Statusmigratorio, :type => :model do

    it "valido" do
      statusmigratorio = FactoryGirl.build(:cor440_gen_statusmigratorio)
      expect(statusmigratorio).to be_valid
      statusmigratorio.destroy
    end

    it "no valido" do
      statusmigratorio = FactoryGirl.build(:cor440_gen_statusmigratorio, nombre: '')
      expect(statusmigratorio).not_to be_valid
      statusmigratorio.destroy
    end

    it "existente" do
      statusmigratorio = Cor440Gen::Statusmigratorio.where(id: 0).take
      expect(statusmigratorio.nombre).to eq("SIN INFORMACIÓN")
    end

  end
end
