# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  username         :string(255)
#  name             :string(255)
#  password_digest  :string(255)
#  avatar           :string(255)
#  size             :string(255)
#  age              :integer
#  email            :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  is_admin         :boolean          default(FALSE)
#  oauth_token      :string(255)
#  oauth_expires_at :datetime
#

class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
  validates :username, :presence => true, :length => { :minimum => 3 }, :uniqueness => true
  validates :password, :presence => true, :length => { :minimum => 6 }, :on => :create
  validates :email, :presence => true, :uniqueness => true
  has_secure_password
  has_many :items, :dependent => :destroy
  has_many :types, :through => :items
  has_many :categories, :through => :items
  has_many :brands, :through => :items
  has_many :outfits
  has_many :friendships, :dependent => :destroy
  has_many :friends, :through => :friendships

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
end