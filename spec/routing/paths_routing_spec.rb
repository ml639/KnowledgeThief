require "spec_helper"

describe PathsController do
  describe "routing" do

    it "routes to #index" do
      get("/paths").should route_to("paths#index")
    end

    it "routes to #new" do
      get("/paths/new").should route_to("paths#new")
    end

    it "routes to #show" do
      get("/paths/1").should route_to("paths#show", :id => "1")
    end

    it "routes to #edit" do
      get("/paths/1/edit").should route_to("paths#edit", :id => "1")
    end

    it "routes to #create" do
      post("/paths").should route_to("paths#create")
    end

    it "routes to #update" do
      put("/paths/1").should route_to("paths#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/paths/1").should route_to("paths#destroy", :id => "1")
    end

  end
end
