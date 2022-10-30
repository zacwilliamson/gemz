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
    click_on 'Like'
    zac.reload
    result_one = zac.reacted?(post)

    expect(page).to have_xpath("//input[@value='Unlike']")
    expect(result_one).to be_truthy

    click_on 'Unlike'
    zac.reload
    post.reload
    result_two = zac.reacted?(post)

    expect(page).to have_xpath("//input[@value='Like']")
    expect(result_two).to be_falsey
  end

  scenario "zac likes zoe's comment" do
    # test here
  end
end
