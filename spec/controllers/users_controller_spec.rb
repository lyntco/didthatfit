require 'rails_helper'

RSpec.describe UsersController, :type => :controller do


  describe 'GET /u' do
    before do
      3.times do |i|
        User.create(:username => "User#{i+1}", :password => 'chicken', :email => "user#{i}@test.com")
      end
      session[:user_id] = User.first.id
    end

    describe 'as HTML' do
      before do
        get :index
      end

      it 'should respond with a status 200' do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it 'should set an instance variable with the users' do
        expect(assigns(:users)).to be # or not to be (nil)
        expect(assigns(:users).count).to eq(3)
        expect(assigns(:users).first.class).to eq(User)
        expect(assigns(:users).first.username).to eq('User1')
      end

      it 'should render the user index template' do
        expect(response).to render_template('index')
      end
    end

  end

  describe 'GET /u/new' do

  end

  describe 'POST /u' do
    describe 'with a valid input' do
      before do
        post :create, {:user => {:username => "User1", :password => 'chicken', :email => "user1@test.com"} }
      end

      it 'should downcase the username' do
        expect(User.first.username).to eq('user1')
      end

      it 'should log the newly sign up user in' do
        expect(session[:user_id]).to eq(User.first.id)
      end

      it 'should redirect to #root path' do
        expect(response.status).to eq(302)
        expect(response).to redirect_to( root_path )
      end

      it 'should increase number of users' do
        expect{
          post :create, {:user => {:username => "User2",
                                   :password => 'chicken',
                                   :email => "user2@test.com"} }
                        }.to change( User, :count ).by(1)
      end

    end

    describe 'without valid input' do
      before do
        post :create, {:user => {:username => ''} }
      end

      it 'should render the new template' do
        expect(response).to render_template('new')
      end

      it 'should not increase the number of users' do
        expect( User.count ).to_not eq(1)
      end
    end

  end

  describe 'PUT /u/:id' do
    describe 'updating user info' do
      before do
        post :create, {:user => {:username => "user1", :password => 'chicken', :email => "user1@test.com"} }
        session[:user_id] = User.first.id
      end

      it 'should redirect to #show path after edit' do
        expect(response.status).to eq(302)
        expect(response).to redirect_to( user_path( assigns(:user).username ) )
      end

      it 'should not increase number of users' do
        expect{
          put :update, {:user => {:username => "user1", :password => 'chickenychick', :email => "user5@test.com"} }
         }.to change( User, :count ).by(0)
      end

    end


  end
end
