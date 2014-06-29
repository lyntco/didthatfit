# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)
#  name            :string(255)
#  password_digest :string(255)
#  avatar          :string(255)
#  size            :string(255)
#  age             :integer
#  email           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  validates :username, :presence => true, :length => { :minimum => 3, :unique => true }
  validates :password, :presence => true, :length => { :minimum => 6 }
  has_secure_password
  has_many :items
end
