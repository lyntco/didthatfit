# == Schema Information
#
# Table name: friendships
#
#  id        :integer          not null, primary key
#  user_id   :integer
#  friend_id :integer
#

require 'rails_helper'

RSpec.describe Friendship, :type => :model do
  it { should belong_to :user }
end
