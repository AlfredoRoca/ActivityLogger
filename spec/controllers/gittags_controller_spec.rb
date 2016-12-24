require 'rails_helper'

RSpec.describe GittagsController, type: :controller do

  let(:admin) { FactoryGirl.create(:user_admin) }
  let(:user) { FactoryGirl.create(:user) }


  let(:project) { FactoryGirl.create :project }
  let(:gittag) { FactoryGirl.create(:gittag, project: project) }

  context "when logged as admin" do
    before(:each) do
      sign_in(admin)
    end

    describe "GET #index" do
      it "returns http success" do
        get :index, project_id: project.id
        expect(response).to have_http_status(:success)
      end
      it "assigns all gittags as @gittags" do
        get :index, {project_id: project.id}
        expect(assigns(:gittags)).to eq([gittag])
      end
    end

    describe "GET #edit" do
      it "returns http success" do
        get :edit, {id: gittag.to_param, project_id: project.id}
        expect(response).to have_http_status(:success)
      end
      it "assigns the requested gittag as @gittag" do
        get :show, {:id => gittag.to_param, project_id: project.id}
        expect(assigns(:gittag)).to eq(gittag)
      end
    end

    describe "GET #show" do
      it "returns http success" do
        get :show, {id: gittag.to_param, project_id: project.id}
        expect(response).to have_http_status(:success)
      end
      it "assigns the requested gittag as @gittag" do
        get :show, {:id => gittag.to_param, project_id: project.id}
        expect(assigns(:gittag)).to eq(gittag)
      end
    end

  end

end
