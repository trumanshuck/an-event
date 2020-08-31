class HomeController < ApplicationController
  skip_before_action :authorized, only: [:index]

  def index
    @messages = [
      "Hasn't this happened already?",
      "Catballs is extremely pleased."
    ]

    @stops = Stop.order(to: :desc)
    @post = Post.in_order.first
  end
end
