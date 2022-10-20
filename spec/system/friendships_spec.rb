require 'rails_helper'

# rails g rspec:system Friendships
# rspec spec/system/friendships_spec.rb

RSpec.describe 'Friendships', type: :system do
  let!(:zac) { create(:user, :zac) }
  let!(:zoe) { create(:user, :zoe) }
  before do
    driven_by(:rack_test)
  end

  scenario "zac sends friend request, page displays 'request sent" do
    login_as(zac)
    visit "/users/#{zoe.id}"
    click_on 'Add friend'
    zac.reload
    result = zac.pending_friends.include?(zoe) && zoe.recived_friends.include?(zac)

    expect(page).to have_content(zoe.username)
    expect(page).to have_xpath("//input[@value='Request sent']")
    expect(result).to be_truthy
  end

  scenario 'zoe sends friend request to zac, (accepted)' do
    login_as(zac)
    zoe.add_friend(zac)
    visit "/users/#{zoe.id}"
    expect(page).to have_xpath("//input[@value='Accept']")
    expect(page).to have_xpath("//input[@value='Decline']")

    click_on 'Accept'
    zac.reload
    result = zac.friends_with?(zoe)
    expect(page).to have_content(zoe.username)
    expect(page).to have_xpath("//input[@value='Unfriend']")
    expect(result).to be_truthy
  end

  scenario 'zoe sends friend request to zac, (declined)' do
    login_as(zac)
    zoe.add_friend(zac)
    visit "/users/#{zoe.id}"
    expect(page).to have_xpath("//input[@value='Accept']")
    expect(page).to have_xpath("//input[@value='Decline']")

    click_on 'Decline'
    zac.reload
    result = zoe.pending_friends.include?(zac) && zac.recived_friends.include?(zoe)
    expect(page).to have_content(zoe.username)
    expect(page).to have_xpath("//input[@value='Add friend']")
    expect(result).to be_falsey
  end
end

# Notes
