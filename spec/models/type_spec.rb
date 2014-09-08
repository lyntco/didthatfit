# == Schema Information
#
# Table name: types
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  warmth      :decimal(, )
#  category_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

require 'rails_helper'

RSpec.describe Type, :type => :model do
  it { should have_many :items }
end
