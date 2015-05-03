# encoding: UTF-8
require 'rails_helper'

module Cor1440Gen

  RSpec.describe Actividadtipo, :type => :model do

    it "valido" do
      actividadtipo = FactoryGirl.build(:cor1440_gen_actividadtipo)
      expect(actividadtipo).to be_valid
      actividadtipo.destroy
    end

    it "no valido" do
      actividadtipo = 
        FactoryGirl.build(:cor1440_gen_actividadtipo, nombre: '')
      expect(actividadtipo).not_to be_valid
      actividadtipo.destroy
    end

  end
end
