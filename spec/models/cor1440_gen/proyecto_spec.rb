# encoding: UTF-8
require 'rails_helper'

module Cor1440Gen
  RSpec.describe Proyecto, :type => :model do

    it "valido" do
      proyecto = FactoryGirl.build(:cor1440_gen_proyecto)
      expect(proyecto).to be_valid
      proyecto.destroy
    end

    it "no valido" do
      proyecto = 
        FactoryGirl.build(:cor1440_gen_proyecto, nombre: '')
      expect(proyecto).not_to be_valid
      proyecto.destroy
    end


  end
end
