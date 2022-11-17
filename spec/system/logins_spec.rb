require 'rails_helper'

RSpec.describe 'Logins', type: :system do
  let!(:zac) { create(:user, :zac) }

  before do
    driven_by(:rack_test)
  end

  it 'shows homepage (not logged in user)' do
    logout(:user)
    visit root_path
    expect(page).to have_content('join us on gemz')
    expect(page).to have_content('Log in')
  end

  it 'shows homepage (logged in user)' do
    login_as(zac)
    visit root_path
    expect(page).to have_content('Settings')
    expect(page).to have_content('Log out')
    expect(page).to have_content("Welcome #{zac.username}")
  end
end
