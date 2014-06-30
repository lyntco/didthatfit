# == Schema Information
#
# Table name: outfits
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

class Outfit < ActiveRecord::Base
  has_many :items
  belongs_to :user
end
