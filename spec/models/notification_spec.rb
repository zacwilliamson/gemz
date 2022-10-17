require 'rails_helper'

# rubocop:disable Metrics/BlockLength

RSpec.describe Notification, type: :model do
  let!(:zac) { create(:user, :zac) }
  let!(:zoe) { create(:user, :zoe) }

  def zac_sends_zoe_request
    zac.add_friend(zoe)
    request = zoe.recived_friendships.find_by(user: zac)
    zoe.notifications.create(notifiable: request)
  end

  def zoe_accepts_zacs_request
    zac_sends_zoe_request
    zoe.add_friend(zac)
    accept = zac.recived_friendships.find_by(user: zoe)
    zac.notifications.create(notifiable: accept)
  end

  describe '#message' do
    before do
      zac_sends_zoe_request
    end
    it 'sends correct message according to notifiable type' do
      notification = zoe.notifications.last
      result = notification.message
      expect(result).to eq('sent you a friend request')
    end
  end

  describe '#friend_request?' do
    before do
      zac_sends_zoe_request
    end
    context 'it returns true when...' do
      it 'the notification is a friend request from other user' do
        notification = zoe.notifications.last
        result = notification.friend_request?
        expect(result).to be_truthy
      end
    end
  end

  describe '#friend_accept?' do
    before do
      zoe_accepts_zacs_request
    end
    context 'it returns true when...' do
      it 'the notification is a friend who accepts the other users request' do
        notification = zac.notifications.last
        result = notification.friend_accept?
        expect(result).to be_truthy
      end
    end
  end

  describe '#sender' do
    before do
      zac_sends_zoe_request
    end
    it 'returns the name of user who sent the notification' do
      notification = zoe.notifications.last
      result = notification.sender
      expect(result).to eq(zac)
    end
  end
end
# rubocop:enable Metrics/BlockLength
