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
#  instagram_id    :string(255)
#  shoe_size       :integer
#  bust            :integer
#  hips            :integer
#  waist           :integer
#  height          :integer
#

class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
  validates :username, :presence => true, :length => { :minimum => 3 }, :uniqueness => true
  validates :password, :presence => true, :length => { :minimum => 6 }, :on => :create
  validates :email, :presence => true, :uniqueness => true
  # validates :instagram_id, :uniqueness => true
  has_secure_password
  has_many :items, :dependent => :destroy
  has_many :types, :through => :items
  has_many :categories, :through => :items
  has_many :brands, :through => :items
  has_many :outfits
  has_many :friendships, :dependent => :destroy
  has_many :friends, :through => :friendships

  def to_param
    username
  end
end
