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

  scenario "zoe friend requests zac, notification displays on zac's home page. he accepts and zoe is notified" do
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
    zoe.reload
    result_two = zoe.friends_with?(zac)
    expect(result_two).to be_truthy
    expect(page).to have_content("#{zac.username} is your new friend")
  end

  scenario 'zoe friend requests zac, he declines, now has empty notifications' do
    login_as(zoe)
    visit "/users/#{zac.id}"
    click_on 'Add friend'
    logout(zoe)
    login_as(zac)

    visit '/'
    request = zac.notifications.last
    zac.reload
    result_one = zac.new_notifications.include?(request)
    click_on '1'
    zac.reload
    result_two = zac.old_notifications.include?(request)
    expect(result_one).to be_truthy
    expect(result_two).to be_truthy

    click_on zoe.username.to_s
    click_on 'Decline'
    zac.reload
    expect(page).to have_content(zac.username)
    expect(zac.notifications).to be_empty
    expect(page).to have_content('0 Notifications')
  end
end
# rubocop:enable Metrics/BlockLength
