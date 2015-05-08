require 'rails_helper'

RSpec.describe UserSessionsController, :type => :controller do
  let(:admin) { FactoryGirl.create(:user_admin) }

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe "GET create" do
    it "returns http success" do
      get :create
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe "GET destroy" do
    it "returns http success" do
      login_user(admin)
      expect(response).to have_http_status(200)
      get :destroy
      expect(response).to redirect_to(login_path)
      expect(response).to have_http_status(302)
    end
  end

end
