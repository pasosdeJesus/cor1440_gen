#require '../../app/controllers/cor1440_gen/actividades_controller'

require 'spec_helper'

module Cor1440Gen
  RSpec.describe ActividadesController, :type => :routing do
    routes { Cor1440Gen::Engine.routes }
    describe "routing" do

      it "routes to #index" do
        expect(:get => "/actividades").to route_to("cor1440_gen/actividades#index")
      end

      it "routes to #new" do
        expect(:get => "/actividades/nueva").to route_to("cor1440_gen/actividades#new")
      end

      it "routes to #show" do
        expect(:get => "/actividades/1").to route_to("cor1440_gen/actividades#show", :id => "1")
      end

      it "routes to #edit" do
        expect(:get => "/actividades/1/edita").to route_to("cor1440_gen/actividades#edit", :id => "1")
      end

      it "routes to #create" do
        expect(:post => "/actividades").to route_to("cor1440_gen/actividades#create")
      end

      it "routes to #update" do
        expect(:put => "/actividades/1").to route_to("cor1440_gen/actividades#update", :id => "1")
      end

      it "routes to #destroy" do
        expect(:delete => "/actividades/1").to route_to("cor1440_gen/actividades#destroy", :id => "1")
      end

    end
  end
end
