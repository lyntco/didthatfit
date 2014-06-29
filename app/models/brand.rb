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
end
