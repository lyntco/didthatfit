# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)
#  name            :string(255)
#  password_digest :string(255)
#  avatar          :string(255)
#  size            :string(255)
#  age             :integer
#  email           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  is_admin        :boolean          default(FALSE)
#  instagram_id    :string(255)
#  shoe_size       :integer
#  bust            :integer
#  hips            :integer
#  waist           :integer
#  height          :integer
#

require 'rails_helper'

RSpec.describe User, :type => :model do
  it { should have_many :items }
end
