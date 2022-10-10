require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation tests' do
    it 'username is present' do
      user = User.new(email: 'sample@example.com', password: 'foobar').save
      expect(user).to eq(false)
    end

    it 'email presence' do
      user = User.new(username: 'mynamehere', password: 'foobar').save
      expect(user).to eq(false)
    end

    it 'password presence' do
      user = User.new(username: 'mynamehere', email: 'sample@example.com').save
      expect(user).to eq(false)
    end

    it 'should save successfully' do
      user = FactoryBot.build(:user, :zac).save
      expect(user).to eq(true)
    end
  end

  describe '#add_friend' do
    let!(:zac) { create(:user, :zac) }
    let!(:zoe) { create(:user, :zoe) }
    context 'when user adds a new friend' do
      before do
        zac.add_friend(zoe)
      end
      it "adds friend to user's pending friends" do
        result = zac.pending_friends.include?(zoe)
        expect(result).to be_truthy
      end
      it "does not add friend to user's active friends" do
        result = zoe.active_friends.include?(zac)
        expect(result).to be_falsey
      end
      it "adds user to friend's recived friends" do
        result = zoe.recived_friends.include?(zac)
        expect(result).to be_truthy
      end
      it "does not add friend to user's active friends" do
        result = zac.active_friends.include?(zoe)
        expect(result).to be_falsey
      end
      it 'creates friendship with correct user_id and friend_id' do
        friendship = zac.friendships.first
        friendship.user_id == zac.id && friendship.friend_id == zoe.id
      end
      it 'creates recived friendship with correct user_id and friend_id' do
        recived_friendship = zoe.recived_friendships.first
        recived_friendship.user_id == zac.id && recived_friendship.friend_id == zoe.id
      end
    end
    context 'it does not work when...' do
      it 'user adds self as friend ' do
        result = zac.add_friend(zac)
        expect(result).to be_falsey
      end
      it 'user adds friend when already sent request' do
        zac.add_friend(zoe)
        zac.add_friend(zoe)
        result = zac.friends.one? { |friend| friend == zoe }
        expect(result).to be_truthy
      end
    end
  end
end
