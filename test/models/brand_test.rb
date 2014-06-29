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

require 'test_helper'

class BrandTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
