class StaticPagesController < ApplicationController
  def home
    return if current_user.nil?

    @post = current_user.posts.build
    @posts = Post.all
  end
end
