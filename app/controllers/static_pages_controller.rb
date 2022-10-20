class StaticPagesController < ApplicationController
  def home
    return if current_user.nil?

    @post = current_user.posts.build
    @posts = current_user.feed
  end
end
