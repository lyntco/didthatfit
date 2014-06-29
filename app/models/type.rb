# == Schema Information
#
# Table name: types
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  warmth      :integer
#  category_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Type < ActiveRecord::Base
end
