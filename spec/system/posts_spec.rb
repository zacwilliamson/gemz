require 'rails_helper'

# rails g rspec:system Posts
# rspec spec/system/posts_spec.rb

RSpec.describe 'Posts', type: :system do
  let!(:zac) { create(:user, :zac) }
  let!(:zoe) { create(:user, :zoe) }

  before do
    driven_by(:rack_test)
  end

  scenario "zac sends friend request, page displays 'request sent" do
    login_as(zac)
    visit '/'
    fill_in 'Write your new post here...', with: 'Test post'
    click_on 'Post'
    zac.reload
    result = zac.posts.last.content == 'Test post'

    expect(page).to have_content('Test post')
    expect(result).to be_truthy
  end
end
