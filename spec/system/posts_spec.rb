require 'rails_helper'

# rails g rspec:system Posts
# rspec spec/system/posts_spec.rb

RSpec.describe 'Posts', type: :system do
  let!(:zac) { create(:user, :zac) }
  let!(:zoe) { create(:user, :zoe) }

  before do
    driven_by(:rack_test)
  end

  scenario 'user makes a post from the homepage then deletes it' do
    login_as(zac)
    visit '/'
    fill_in 'Write your new post here...', with: 'Test post'
    click_on 'Post'
    zac.reload
    result_one = zac.posts.last.content == 'Test post'
    expect(page).to have_content('Test post')
    expect(result_one).to be_truthy

    click_on 'Delete'
    zac.reload
    result_two = zac.posts.empty?
    expect(page).to_not have_content('Test post')
    expect(result_two).to be_truthy
  end

  scenario 'users feed displays their own posts and friends post' do
    zoe.posts.create(content: 'Yee yee')
    zoe.add_friend(zac)
    zac.add_friend(zoe)
    login_as(zac)
    visit '/'
    expect(page).to have_content('Yee yee')
    expect(page).to have_content(zoe.username)

    visit "/users/#{zoe.id}"
    click_on 'Unfriend'
    visit '/'
    expect(page).to_not have_content('Yee yee')
  end
end
