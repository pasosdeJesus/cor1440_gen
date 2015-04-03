# encoding: UTF-8
require 'rails_helper'

module Sivel2Sjr
  RSpec.describe Comosupo, :type => :model do

    it "valido" do
      comosupo = FactoryGirl.build(:sivel2_sjr_comosupo)
      expect(comosupo).to be_valid
      comosupo.destroy
    end

    it "no valido" do
      comosupo = FactoryGirl.build(:sivel2_sjr_comosupo, nombre: '')
      expect(comosupo).not_to be_valid
      comosupo.destroy
    end

    it "existente" do
      comosupo = Comosupo.where(id: 1).take
      expect(comosupo.nombre).to eq("SIN INFORMACIÓN")
    end

  end
end
