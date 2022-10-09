require 'rails_helper'

RSpec.describe 'Logins', type: :system do
  let!(:user1) { create(:user) }

  before do
    driven_by(:rack_test)
  end

  it 'shows homepage (not logged in user)' do
    visit root_path
    expect(page).to have_content('Sign in')
    expect(page).to have_content('Sign up')
    expect(page).to have_content('Welcome to Fakebook')
  end

  it 'redirects to login if visiting unauthorized page' do
    # visit 
  end

  it 'shows homepage (logged in user)' do
    login_as(user1)
    visit root_path
    expect(page).to have_content('Edit profile')
    expect(page).to have_content('Log out')
    expect(page).to have_content("Welcome #{user1.username}")
  end
end
