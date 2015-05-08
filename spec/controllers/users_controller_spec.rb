require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
		
    let(:admin) { FactoryGirl.create(:user_admin) }
		let(:user) { FactoryGirl.create(:user) }
		let(:user1) { FactoryGirl.create(:user) }
		let(:user2) { FactoryGirl.create(:user) }

  let(:valid_attributes) {
    FactoryGirl.attributes_for(:user)
  }

  let(:invalid_attributes) {
    FactoryGirl.attributes_for(:user_invalid)
  }

  context "when user is admin" do
		before(:each) do
      login_user(admin)
    end
  
    describe "when login" do
      it "sets the current user variable" do
        expect(controller.current_user).to be_present
      end
      it "the current user is admin" do
        expect(controller.current_user.admin).to be true
      end
    end

    describe "GET new" do
      it "returns http success" do
        get :new
        expect(response).to be_success
        expect(response).to have_http_status(200)
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

    describe "POST create" do
      describe "with valid params" do
        it "creates a new User" do
          expect {
            post :create, {:user => valid_attributes}
          }.to change(User, :count).by(1)
        end

        it "assigns a newly created user as @user" do
          post :create, {:user => valid_attributes}
          expect(assigns(:user)).to be_a(User)
          expect(assigns(:user)).to be_persisted
        end

        it "redirects to the users list" do
          post :create, {:user => valid_attributes}
          expect(response).to redirect_to(users_path)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved user as @user" do
          post :create, {:user => invalid_attributes}
          expect(assigns(:user)).to be_a_new(User)
        end

        it "re-renders the 'new' template" do
          post :create, {:user => invalid_attributes}
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        let(:new_attributes) {
          FactoryGirl.attributes_for(:user)
        }

        it "updates the requested user" do
          user = User.create! valid_attributes
          put :update, {:id => user.to_param, :user => new_attributes}
          user.reload
          expect(assigns(:user)).to eq(user)
        end

        it "assigns the requested user as @user" do
          user = User.create! valid_attributes
          put :update, {:id => user.to_param, :user => valid_attributes}
          expect(assigns(:user)).to eq(user)
        end

        it "redirects to the user" do
          user = User.create! valid_attributes
          put :update, {:id => user.to_param, :user => valid_attributes}
          expect(response).to redirect_to(user)
        end
      end

      describe "with invalid params" do
        it "assigns the user as @user" do
          user = User.create! valid_attributes
          put :update, {:id => user.to_param, :user => invalid_attributes}
          expect(assigns(:user)).to eq(user)
        end

        it "re-renders the 'edit' template" do
          user = User.create! valid_attributes
          put :update, {:id => user.to_param, :user => invalid_attributes}
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested user" do
        user = User.create! valid_attributes
        expect {
          delete :destroy, {:id => user.to_param}
        }.to change(User, :count).by(-1)
      end

      it "redirects to the users list" do
        user = User.create! valid_attributes
        delete :destroy, {:id => user.to_param}
        expect(response).to redirect_to(users_path)
      end
    end

  end

  context "when user is not admin" do
    before(:each) do
      login_user(user)
    end
  
    describe "when login" do
      it "sets the current user variable" do
        expect(controller.current_user).to be_present
      end
      it "the current user is not admin" do
        expect(controller.current_user.admin).to be false
      end
    end

    describe "GET new" do
      it "returns http success" do
        get :new
        expect(response).to be_success
        expect(response).to have_http_status(200)
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

    describe "POST create" do
      describe "with valid params" do
        it "creates a new User" do
          expect {
            post :create, {:user => valid_attributes}
          }.to change(User, :count).by(1)
        end

        it "assigns a newly created user as @user" do
          post :create, {:user => valid_attributes}
          expect(assigns(:user)).to be_a(User)
          expect(assigns(:user)).to be_persisted
        end

        it "redirects to the users list" do
          post :create, {:user => valid_attributes}
          expect(response).to redirect_to(users_path)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved user as @user" do
          post :create, {:user => invalid_attributes}
          expect(assigns(:user)).to be_a_new(User)
        end

        it "re-renders the 'new' template" do
          post :create, {:user => invalid_attributes}
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        let(:new_attributes) {
          FactoryGirl.attributes_for(:user)
        }

        it "cannot update the requested user" do
          put :update, {:id => user.to_param, :user => new_attributes}
          user.reload
          expect(assigns(:user)).not_to eq(user)
        end

        it "assigns the requested user as @user" do
          put :update, {:id => user.to_param, :user => valid_attributes}
          expect(assigns(:user)).not_to eq(user)
        end

        it "redirects to the root" do
          put :update, {:id => user.to_param, :user => valid_attributes}
          expect(response).to redirect_to(root_path)
        end
      end

      describe "with invalid params" do
        it "redirects to root" do
          put :update, {:id => user.to_param, :user => invalid_attributes}
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

end
