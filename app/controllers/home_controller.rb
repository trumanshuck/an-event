class HomeController < ApplicationController
  skip_before_action :authorized, only: [:index]

  def index
    @stops = Stop.order(to: :desc)
    @post = recent_post
    @new_posts = new_posts_after(@post)
    @email = Email.new
  end

  private

  def recent_post
    return Post.in_order.first if session[:postslug].blank?

    Post.find_by(slug: session[:postslug])
  end

  def new_posts_after(post)
    return 0 if post.blank?
    post_arel = Post.arel_table

    Post.where(post_arel[:created_at].gt(post.created_at)).count
  end
end
