require 'rails_helper'

RSpec.describe Outfit, :type => :model do
  it { should belong_to :user }
end