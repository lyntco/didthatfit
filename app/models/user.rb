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
#  is_admin        :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
  validates :username, :presence => true, :length => { :minimum => 3 }, :uniqueness => true
  validates :password, :presence => true, :length => { :minimum => 6 }, :on => :create
  validates :email, :presence => true, :uniqueness => true
  has_secure_password
  has_many :items
  has_many :types, :through => :items
  has_many :categories, :through => :items
  has_many :brands, :through => :items
  has_many :outfits
  has_many :friendships
  has_many :friends, :through => :friendships
end
