# == Schema Information
#
# Table name: brands
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  image      :string(255)
#  website    :string(255)
#  address    :text
#  created_at :datetime
#  updated_at :datetime
#

class Brand < ActiveRecord::Base
  mount_uploader :image, BrandsUploader
  has_many :items
  has_many :types, :through => :items
  has_many :categories, :through => :items
  has_many :users, :through => :items
end
