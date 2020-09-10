class HomeController < ApplicationController
  skip_before_action :authorized, only: [:index]

  def index
    @stops = Stop.order(to: :desc)
    @post = Post.in_order.first
  end
end
