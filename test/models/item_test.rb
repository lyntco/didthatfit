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

require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
