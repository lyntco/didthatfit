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

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
