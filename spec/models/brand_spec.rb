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

require 'rails_helper'

RSpec.describe Brand, :type => :model do
  it { should have_many :items }
end
