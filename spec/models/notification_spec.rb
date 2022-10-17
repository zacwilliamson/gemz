require 'rails_helper'

RSpec.describe Notification, type: :model do
  let!(:zac) { create(:user, :zac) }
  let!(:zoe) { create(:user, :zoe) }

  # describe '#message' do
  #   it 'sends correct message according to notifiable type' do
  #     result = notification.message
  #       expect(result).to be_truthy
  #   end
  # end
end
