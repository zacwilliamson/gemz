require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let!(:zac) { create(:user, :zac) }
  let!(:zoe) { create(:user, :zoe) }
  let!(:friendship) { create(:friendship, user_id: zac.id, friend_id: zoe.id) }

  it 'should be valid' do
    expect(friendship).to be_valid
  end

  it 'should require user_id' do
    friendship.user_id = nil
    expect(friendship).not_to be_valid
  end

  it 'should require friend_id' do
    friendship.friend_id = nil
    expect(friendship).not_to be_valid
  end
end
