require "rails_helper"

module Cor1440Gen
  RSpec.describe InformesController, type: :routing do
    routes { Cor1440Gen::Engine.routes }
    describe "routing" do

      it "routes to #index" do
        expect(:get => "/informes").to route_to("cor1440_gen/informes#index")
      end

      it "routes to #new" do
        expect(:get => "/informes/nuevo").to route_to("cor1440_gen/informes#new")
      end

      it "routes to #show" do
        expect(:get => "/informes/1").to route_to("cor1440_gen/informes#show", :id => "1")
      end

      it "routes to #edit" do
        expect(:get => "/informes/1/edita").to route_to("cor1440_gen/informes#edit", :id => "1")
      end

      it "routes to #create" do
        expect(:post => "/informes").to route_to("cor1440_gen/informes#create")
      end

      it "routes to #update via PUT" do
        expect(:put => "/informes/1").to route_to("cor1440_gen/informes#update", :id => "1")
      end

      it "routes to #update via PATCH" do
        expect(:patch => "/informes/1").to route_to("cor1440_gen/informes#update", :id => "1")
      end

      it "routes to #destroy" do
        expect(:delete => "/informes/1").to route_to("cor1440_gen/informes#destroy", :id => "1")
      end

    end
  end
end
