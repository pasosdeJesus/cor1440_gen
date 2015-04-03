# encoding: UTF-8
require 'rails_helper'

module Sivel2Sjr
  RSpec.describe Statusmigratorio, :type => :model do

    it "valido" do
      statusmigratorio = FactoryGirl.build(:sivel2_sjr_statusmigratorio)
      expect(statusmigratorio).to be_valid
      statusmigratorio.destroy
    end

    it "no valido" do
      statusmigratorio = FactoryGirl.build(:sivel2_sjr_statusmigratorio, nombre: '')
      expect(statusmigratorio).not_to be_valid
      statusmigratorio.destroy
    end

    it "existente" do
      statusmigratorio = Sivel2Sjr::Statusmigratorio.where(id: 0).take
      expect(statusmigratorio.nombre).to eq("SIN INFORMACIÓN")
    end

  end
end
