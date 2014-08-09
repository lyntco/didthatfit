require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do
  before do
    3.times do |i|
      User.create(:username => "User#{i+1}", :password => 'chicken', :email => "user#{i}@test.com")
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

    end

  end

end