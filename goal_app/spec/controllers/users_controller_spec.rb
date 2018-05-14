require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    it "render new user's template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do

    context "with valid params" do
      it "logs in user" do
        post :create, params: {user: {username: 'kevin', password: 'password'}}
        user = User.find_by(username: 'kevin')
        expect(session[:session_token]).to eq(user.session_token)
      end

      it "redirects to user show page" do
        post :create, params: {user: {username: 'kevin', password: 'password'}}
        user = User.find_by(username: 'kevin')
        expect(response).to redirect_to(user_url(user))
      end

    end

    context "with invalid params" do
      it "validates presence of password & renders the new template" do
        post :create, params: {user: {username: 'kevin' }}
        expect(response).to render_template(:new)
        expect(flash[:errors]).to be_present
      end

    end
  end

end
