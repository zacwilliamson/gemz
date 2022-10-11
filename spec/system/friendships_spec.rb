require 'rails_helper'

# rails g rspec:system Friendships
# rspec spec/system/friendships_spec.rb

RSpec.describe 'Friendships', type: :system do
  let!(:zac) { create(:user, :zac) }
  let!(:zoe) { create(:user, :zoe) }
  before do
    driven_by(:rack_test)
  end

  scenario "add friend button sends request and displays 'request sent'" do
    login_as(zac)
    visit "/users/#{zoe.id}"
    click_on 'Add friend'
    zac.reload
    result = zac.pending_friends.include?(zoe) && zoe.recived_friends.include?(zac)

    expect(page).to have_content(zoe.username)
    expect(page).to have_xpath("//input[@value='Request sent']")
    expect(result).to be_truthy
  end
end

# Notes

# How can I check that a form field is prefilled correctly using capybara?
# https://stackoverflow.com/questions/10503802/how-can-i-check-that-a-form-field-is-prefilled-correctly-using-capybara
