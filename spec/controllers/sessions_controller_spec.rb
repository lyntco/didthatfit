require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do
  before do
    3.times do |i|
      User.create(:username => "User#{i+1}", :password => "chicken#{i+1}", :email => "user#{i}@test.com")
    end
  end

  describe 'GET /login' do
    it "should show login form" do
    end
  end

  describe 'POST /login' do
    it 'should not log you in if you have the incorrect info' do
    end

    it 'should log you in if you have the correct info' do
    end
  end

  describe 'DELETE /login' do
    it 'should log the user out' do
      expect( session[:user_id] ).to_not be
    end

    it 'should clear the instagram id' do
      expect( session[:instagram_id] ).to_not be
    end

    it 'should redirect to root path' do
      expect(response).to redirect_to( root_path )
    end
  end

end