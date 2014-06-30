# == Schema Information
#
# Table name: items
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  type_id    :integer
#  brand_id   :integer
#  size       :string(255)
#  fit        :string(255)
#  created_at :datetime
#  updated_at :datetime
#  image      :string(255)
#  user_id    :integer
#

class Item < ActiveRecord::Base
  belongs_to :user
  belongs_to :brand
  belongs_to :type
  belongs_to :category
  # has_many_and_belongs_to :outfits
end
