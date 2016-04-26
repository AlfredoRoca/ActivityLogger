require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
    
    let(:admin) { FactoryGirl.create(:user_admin) }
    let(:user) { FactoryGirl.create(:user) }
    let(:user1) { FactoryGirl.create(:user) }
    let(:user2) { FactoryGirl.create(:user) }

  context "when user is admin" do
    before(:each) do
      sign_in(admin)
    end
  
    describe "when login" do
      it "sets the current user variable" do
        expect(controller.current_user).to be_present
      end
      it "the current user is admin" do
        expect(controller.current_user.admin).to be true
      end
    end

    describe "GET profile" do
      it "returns http success" do
        get :profile
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
      it "renders the edit template" do
        get :profile
        expect(response).to render_template(:edit)
      end
    end

    describe "GET index" do
      it "returns http success" do
        get :index, {}
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
      it "renders the index template" do
        get :index, {}
        expect(response).to render_template(:index)
      end
      it "shows the list of users" do
        get :index, {}
        expect(assigns(:users)).to match_array([admin, user1, user2])
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested user" do
          user = FactoryGirl.create :user
          put :update, {:id => user.to_param, :user => { name: Faker::Lorem.word }}
          user.reload
          expect(assigns(:user)).to eq(user)
        end

        it "assigns the requested user as @user" do
          user = FactoryGirl.create :user
          put :update, {:id => user.to_param, :user => { name: Faker::Lorem.word }}
          expect(assigns(:user)).to eq(user)
        end

        it "redirects to the user" do
          user = FactoryGirl.create :user
          put :update, {:id => user.to_param, :user => { name: Faker::Lorem.word }}
          expect(response).to redirect_to(user)
        end
      end

      describe "with invalid params" do
        it "assigns the user as @user" do
          user = FactoryGirl.create :user
          put :update, {:id => user.to_param, :user => { email: nil }}
          expect(assigns(:user)).to eq(user)
        end

        it "re-renders the 'edit' template" do
          user = FactoryGirl.create :user
          put :update, {:id => user.to_param, :user => { email: nil }}
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested user" do
        user = FactoryGirl.create :user
        expect {
          delete :destroy, {:id => user.to_param}
        }.to change(User, :count).by(-1)
      end

      it "redirects to the users list" do
        user = FactoryGirl.create :user
        delete :destroy, {:id => user.to_param}
        expect(response).to redirect_to(users_path)
      end
    end

  end

# TODO enable tests when pundit
=begin
  context "when user is not admin" do
    before(:each) do
      sign_in(user)
    end
  
    describe "when login" do
      it "sets the current user variable" do
        expect(controller.current_user).to be_present
      end
      it "the current user is not admin" do
        expect(controller.current_user.admin).to be false
      end
    end

    describe "GET profile" do
      it "returns http success" do
        get :profile
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
      it "renders the edit template" do
        get :profile
        expect(response).to render_template(:edit)
      end
    end

    describe "GET index" do
      it "returns http success" do
        get :index, {}
        expect(response).to have_http_status(:redirect)
      end
      it "doesn't render the index template" do
        get :index, {}
        expect(response).not_to render_template(:index)
      end
    end

    describe "PUT update" do
      describe "with valid params" do

        it "cannot update the requested user" do
          put :update, {:id => user.to_param, :user => { name: Faker::Lorem.word }}
          user.reload
          expect(assigns(:user)).not_to eq(user)
        end

        it "assigns the requested user as @user" do
          put :update, {:id => user.to_param, :user => { name: Faker::Lorem.word }}
          expect(assigns(:user)).not_to eq(user)
        end

        it "redirects to the root" do
          put :update, {:id => user.to_param, :user => { name: Faker::Lorem.word }}
          expect(response).to redirect_to(root_path)
        end
      end

      describe "with invalid params" do
        it "redirects to root" do
          put :update, {:id => user.to_param, :user => { email: nil }}
          expect(response).to redirect_to(root_path)
        end
      end
    end

    describe "DELETE destroy" do
      it "can't destroy the requested user" do
        expect {
          delete :destroy, {:id => user.to_param}
        }.to change(User, :count).by(0)
      end

      it "redirects to the root path" do
        delete :destroy, {:id => user.to_param}
        expect(response).to redirect_to(root_path)
      end
    end

  end
=end

end
