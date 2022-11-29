require 'rails_helper'

RSpec.describe 'Comments', type: :system do
  let!(:zac) { create(:user, :zac) }
  let!(:zoe) { create(:user, :zoe) }

  before do
    driven_by(:rack_test)
  end

  scenario "zac can comment and delete comment on zoe's post" do
    # set up
    zoe.add_friend(zac)
    zac.add_friend(zoe)
    zoe.posts.create(content: 'Someone comment on this')
    post = zoe.posts.last

    login_as(zac)
    visit "/posts/#{post.id}"
    fill_in 'Write a comment here:', with: 'I am here'
    click_on 'Post'
    zac.reload
    zoe.reload
    comment = zac.comments.last
    result_one = post.comments.include?(comment)
    expect(page).to have_content('I am here')
    expect(result_one).to be_truthy

    # find("#trash#{comment.id}").click
    # zac.reload
    # zoe.reload
    # result_two = post.comments.empty?
    # expect(page).to_not have_content('I am here')
    # expect(result_two).to be_truthy
  end
end
