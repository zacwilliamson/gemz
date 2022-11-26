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
    expect(result_one).to be_truthy

    click_on 'Notifications'
    expect(page).to have_content("#{zoe.username} sent you a friend request")
    expect(page).to have_xpath("//input[@value='Accept']")
    expect(page).to have_xpath("//input[@value='Decline']")

    click_on 'Accept'
    expect(page).to have_content("#{zoe.username} 's friend request was accepted")
    logout(zac)
    login_as(zoe)
    visit '/'
    click_on 'Notifications'
    zoe.reload
    result_two = zoe.friends_with?(zac)
    expect(result_two).to be_truthy
    expect(page).to have_content("#{zac.username} accepted your friend request")
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
    click_on 'Notifications'
    zac.reload
    result_two = zac.old_notifications.include?(request)
    expect(result_one).to be_truthy
    expect(result_two).to be_truthy
    expect(page).to have_xpath("//input[@value='Accept']")
    expect(page).to have_xpath("//input[@value='Decline']")

    click_on 'Decline'
    zac.reload
    expect(page).to have_content('Notifications')
    expect(zac.notifications).to be_empty

    visit "/users/#{zoe.id}/notifications"
    expect(page).to have_content('Notifications')
  end

  scenario 'a user is notified when their post is liked' do
    # set up
    zoe.add_friend(zac)
    zac.add_friend(zoe)
    zoe.posts.create(content: 'Simple test post')
    post = zoe.posts.last

    login_as(zac)
    visit '/'
    find('.like').click
    reaction = zac.reactions.find_by(reactable: post)
    result_one = zoe.notifications.last.notifiable_id == reaction.id
    expect(result_one).to be_truthy

    logout(zac)
    login_as(zoe)
    visit '/'

    visit "/users/#{zoe.id}/notifications"
    expect(page).to have_content("#{zac.username} liked your post")
  end

  scenario 'a user is not notified when they like thier own posts' do
    # set up
    zac.posts.create(content: 'Simple test post')
    post = zac.posts.last

    login_as(zac)
    visit '/'
    find('.like').click
    result_one = zac.reacted?(post) && zac.notifications.empty?
    expect(result_one).to be_truthy
  end

  scenario 'a user is notified when their post recives a comment' do
    # set up
    zoe.add_friend(zac)
    zac.add_friend(zoe)
    zoe.posts.create(content: 'Simple test post')
    post = zoe.posts.last

    login_as(zac)
    visit "/posts/#{post.id}"
    fill_in 'Comment here...', with: 'Here is your comment'
    click_on 'Post'
    result_one = post.comments.last.content == 'Here is your comment'
    expect(page).to have_content('Here is your comment')
    expect(result_one).to be_truthy

    logout(zac)
    login_as(zoe)
    visit "/users/#{zoe.id}/notifications"
    expect(page).to have_content("#{zac.username} commented on your post")
  end

  scenario 'a user is not notified when they comment their own posts' do
    # set up
    zac.posts.create(content: 'Simple test post')
    post = zac.posts.last

    login_as(zac)
    visit "/posts/#{post.id}"
    fill_in 'Comment here...', with: 'My comment on my post'
    click_on 'Post'
    zac.reload
    result_one = zac.notifications.empty?
    expect(result_one).to be_truthy
    expect(page).to have_content('My comment on my post')
  end
end
# rubocop:enable Metrics/BlockLength
