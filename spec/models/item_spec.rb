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

require 'rails_helper'

RSpec.describe Item, :type => :model do
  it { should belong_to :user }
end
