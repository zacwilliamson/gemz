require 'rails_helper'

RSpec.describe 'Notifications', type: :system do
  let!(:zac) { create(:user, :zac) }
  let!(:zoe) { create(:user, :zoe) }
  before do
    driven_by(:rack_test)
  end

  scenario "zoe sends friends request to zac and notification shows up on zac's home page" do
    login_as(zoe)
    visit "/users/#{zac.id}"
    click_on 'Add friend'
    logout(:zoe)
    login_as(zac)
    visit '/'
    zac.reload
    result_one = zac.recived_request?(zoe) && zac.notifications.first.notifiable_type == 'Friendship'

    expect(page).to have_content('1 Notifications')
    expect(result_one).to be_truthy

    click_on '1'
    expect(page).to have_content("#{zoe.username} sent you a friend request")
  end
end
