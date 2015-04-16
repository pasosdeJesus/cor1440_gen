# encoding: UTF-8
require 'rails_helper'
module Cor1440Gen
  RSpec.describe Actividad, :type => :model do

    it "valido" do
      actividad = FactoryGirl.build(:cor1440_gen_actividad)
      expect(actividad).to be_valid
      actividad.destroy
    end

    it "no valido" do
      actividad = FactoryGirl.build(:cor1440_gen_actividad, oficina_id: nil)
      expect(actividad).not_to be_valid
      actividad.destroy
    end

  end
end
