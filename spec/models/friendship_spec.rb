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

  describe '#initial_request?' do
    context 'when the users are friends with eachother' do
      before do
        zac.add_friend(zoe)
        zoe.add_friend(zac)
      end
      it 'returns true if first request was sent' do
        request = zac.friendships.find_by(friend: zoe)
        result = request.initial_request?
        expect(result).to eql(true)
      end
      it 'returns false if second reqeust was sent' do
        request = zoe.friendships.find_by(friend: zac)
        result = request.initial_request?
        expect(result).to eql(false)
      end
    end
    context 'it returns nil when' do
      it 'one of them sent a pending request' do
        zac.add_friend(zoe)
        request = zac.friendships.find_by(friend: zoe)
        result = request.initial_request?
        expect(result).to eql(nil)
      end
    end
  end
end
