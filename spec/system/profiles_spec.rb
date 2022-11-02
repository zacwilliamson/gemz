require 'rails_helper'

RSpec.describe 'Profiles', type: :system do
  let!(:zac) { create(:user, :zac) }
  let!(:zoe) { create(:user, :zoe) }

  before do
    driven_by(:rack_test)
  end

  scenario 'user can set up profile and display info on their show page' do
    login_as(zac)
    visit "/users/#{zac.id}/profiles/new"
    fill_in 'Full Name', with: 'Zac Williamson'
    fill_in 'Location', with: 'Las Vegas'
    fill_in 'Website', with: 'fakebook.com'
    fill_in 'Bio', with: 'I am just a test subject'
    click_on 'Create'
    expect(page).to have_content('Zac Williamson')
    expect(page).to have_content('Las Vegas')
    expect(page).to have_content('fakebook.com')
    expect(page).to have_content('I am just a test subject')
  end
end
