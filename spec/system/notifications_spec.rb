require 'rails_helper'

# rails g rspec:system Notifications
# rspec spec/system/notifications_spec.rb

# rubocop:disable Metrics/BlockLength
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
    logout(zoe)
    login_as(zac)

    visit '/'
    zac.reload
    result_one = zac.recived_request?(zoe) && zac.notifications.last.notifiable_type == 'Friendship'
    expect(page).to have_content('1 Notifications')
    expect(result_one).to be_truthy

    click_on '1'
    expect(page).to have_content("#{zoe.username} sent you a friend request")

    click_on zoe.username.to_s
    expect(page).to have_content(zoe.username)
    expect(page).to have_xpath("//input[@value='Accept']")
    expect(page).to have_xpath("//input[@value='Decline']")

    click_on 'Accept'
    logout(zac)
    login_as(zoe)
    visit '/'
    click_on '1'
    sleep(3)
    zoe.reload
    result_two = zoe.friends_with?(zac)
    expect(result_two).to be_truthy
    # expect(page).to have_content("#{zac.username} accepted your friend request")
  end
end
# rubocop:enable Metrics/BlockLength
