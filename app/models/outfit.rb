# == Schema Information
#
# Table name: outfits
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

class Outfit < ActiveRecord::Base
  has_and_belongs_to_many :items
  belongs_to :user
end
