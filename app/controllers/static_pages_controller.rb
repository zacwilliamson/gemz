class StaticPagesController < ApplicationController
  def home
    @post = current_user.posts.build
    @posts = Post.all
  end
end
