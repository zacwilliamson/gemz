require 'rails_helper'

# rubocop:disable Metrics/BlockLength

RSpec.describe User, type: :model do
  let!(:zac) { create(:user, :zac) }
  let!(:zoe) { create(:user, :zoe) }

  describe '#add_friend' do
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

  describe '#unfriend' do
    context 'when a user unfriends an exisitng friend' do
      before do
        zac.add_friend(zoe)
        zoe.add_friend(zac)
        zac.unfriend(zoe)
      end
      it "removes other user from user's friend list" do
        result = zac.friends.include?(zoe)
        expect(result).to be_falsey
      end
      it "removes user from other user's friend list" do
        result = zoe.friends.include?(zac)
        expect(result).to be_falsey
      end
      it 'removes friendship from both users' do
        result = zac.friendships.empty? && zoe.friendships.empty?
        expect(result).to be_truthy
      end
      it 'removes recived friendship from both users' do
        result = zac.recived_friendships.empty? && zoe.recived_friendships.empty?
        expect(result).to be_truthy
      end
    end
  end

  describe '#friends_with?' do
    context 'returns true when...' do
      before do
        zac.add_friend(zoe)
        zoe.add_friend(zac)
      end
      it 'other user is an active friend' do
        result = zac.friends_with?(zoe)
        expect(result).to be_truthy
      end
    end
    context 'returns false when...' do
      it 'other user is a pending friend' do
        zac.add_friend(zoe)
        result = zac.friends_with?(zoe)
        expect(result).to be_falsey
      end
      it 'no friendship has been initiated' do
        result = zac.friends_with?(zoe)
        expect(result).to be_falsey
      end
      it 'user unfriends other user' do
        zac.add_friend(zoe)
        zoe.add_friend(zac)
        zac.unfriend(zoe)
        result = zac.friends_with?(zoe)
        expect(result).to be_falsey
      end
    end

    # describe '#recived_request?' do
    #   context 'it returns true when...' do
    #     before do
    #       zac.add_friend(zoe)
    #     end
    #     it 'a user recives a friend request' do
    #       result = zoe.recived_request?(zac)
    #       expect(result).to be_truthy
    #     end
    #   end
    # end

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
        user = User.new(username: 'mynamehere', email: 'sample@example.com', password: 'password').save
        expect(user).to eq(true)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
