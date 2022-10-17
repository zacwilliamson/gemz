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

  describe '#request_sender' do
    before do
      zac_sends_zoe_request
    end
    it 'returns the name of user who sent the request' do
      notification = zoe.notifications.last
      result = notification.request_sender
      expect(result).to eq(zac)
    end
  end
end
# rubocop:enable Metrics/BlockLength