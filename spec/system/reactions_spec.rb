require 'rails_helper'

RSpec.describe 'Reactions', type: :system do
  let!(:zac) { create(:user, :zac) }
  let!(:zoe) { create(:user, :zoe) }

  before do
    driven_by(:rack_test)
  end

  scenario "zac likes zoe's post" do
    # set up
    zoe.add_friend(zac)
    zac.add_friend(zoe)
    zoe.posts.create(content: 'Simple test post')
    post = zoe.posts.last

    login_as(zac)
    visit '/'
    find('.like').click
    zac.reload
    result_one = zac.reacted?(post)
    expect(page).to have_xpath("//ion-icon[@name='heart']")
    expect(result_one).to be_truthy

    find('.unlike').click
    zac.reload
    post.reload
    result_two = zac.reacted?(post)
    expect(page).to have_xpath("//ion-icon[@name='heart-outline']")
    expect(result_two).to be_falsey
  end

  scenario "zac likes zoe's comment (and zoe is not notified)" do
    # set up
    zoe.add_friend(zac)
    zac.add_friend(zoe)
    zoe.posts.create(content: 'Simple test post')
    post = zoe.posts.last
    zac.reactions.create(reactable: post)
    comment = zac.comments.create(post: post, content: 'Hey its my comment!')

    login_as(zac)
    visit "/posts/#{post.id}"
    find('.like').click
    zac.reload
    zoe.reload
    result_one = zac.reacted?(comment)
    result_two = zoe.notifications.empty?

    expect(result_one).to be_truthy
    expect(result_two).to be_truthy
    expect(page).to have_content('1')
  end
end
