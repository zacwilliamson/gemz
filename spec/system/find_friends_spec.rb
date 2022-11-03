require 'rails_helper'

RSpec.describe 'FindFriends', type: :system do
  let!(:zac) { create(:user, :zac) }
  let!(:zoe) { create(:user, :zoe) }

  before do
    driven_by(:rack_test)
  end

  scenario 'zac can find friends on users#index page' do
    login_as(zac)
    visit '/users'
    expect(page).to have_content(zoe.username)
    expect(page).to have_xpath("//input[@value='Add friend']")

    click_on 'Add friend'
    zac.reload
    zoe.reload
    result_one = zac.pending_friends.include?(zoe) && zoe.recived_request?(zac)
    result_two = zoe.notifications.empty?
    expect(result_one).to be_truthy
    expect(result_two).to be_falsey
  end
end
