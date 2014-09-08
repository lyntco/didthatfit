# == Schema Information
#
# Table name: outfits
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

require 'rails_helper'

RSpec.describe Outfit, :type => :model do
  it { should belong_to :user }
end
