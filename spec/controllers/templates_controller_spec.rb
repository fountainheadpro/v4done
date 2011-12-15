require 'spec_helper'

describe TemplatesController do
  let(:user) { Factory(:user) }

  before(:each) do
    sign_in user
  end

  describe "GET index" do
    it "assigns all templates as @templates" do
      template = Factory(:template, creator: user)
      get :index
      assigns(:templates).should eq([template])
    end
  end

  describe "GET show" do
    it "respond with :success" do
      template = Factory(:template, creator: user)
      get :show, id: template.id, format: :json
      response.should be_success
    end
  end

  describe "POST create" do
    describe "with valid params" do
      let(:valid_params) { { template: Factory.attributes_for(:template), format: :json } }

      it "creates a new Template" do
        expect {
          post :create, valid_params
        }.to change(Template, :count).by(1)
      end

      it "respond with :success" do
        post :create, valid_params
        response.should be_success
      end
    end

    describe "with invalid params" do
      let(:invalid_params) { { template: {}, format: :json } }

      it "response with error message" do
        post :create, invalid_params
        response.body.should include('{"title":["can\'t be blank"]}')
      end

      it "respond with :unprocessable_entity" do
        post :create, invalid_params
        response.code.should eq("422")
      end
    end
  end

  describe "PUT update" do
    let(:template) { Factory(:template, creator: user) }

    it "updates the requested template" do
      Template.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
      put :update, id: template.id, template: {'these' => 'params'}
    end

    describe "with valid params" do
      let(:valid_params) { { id: template.id, template: Factory.attributes_for(:template), format: :json } }

      it "response with blank body" do
        put :update, valid_params
        response.body.should eq("{}")
      end

      it "respond with :success" do
        put :update, valid_params
        response.should be_success
      end
    end

    describe "with invalid params" do
      let(:invalid_params) { { id: template.id, template: { title: '' }, format: :json } }

      it "response with error message" do
        put :update, invalid_params
        response.body.should include('{"title":["can\'t be blank"]}')
      end

      it "respond with :unprocessable_entity" do
        put :update, invalid_params
        response.code.should eq("422")
      end
    end
  end

  describe "DELETE destroy" do

    it "destroys the requested template" do
      template = Factory(:template, creator: user)
      expect {
        delete :destroy, id: template.id, format: :json
      }.to change(Template, :count).by(-1)
    end

    it "redirects to the templates list" do
      template = Factory(:template, creator: user)
      delete :destroy, id: template.id, format: :json
      response.should be_success
    end
  end

end
