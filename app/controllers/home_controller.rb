class HomeController < ApplicationController
  def index
    @messages = [
      "Hasn't this happened already?",
      "Catballs is extremely pleased."
    ]

    @stops = Stop.order(from: :desc)
    @previous_stops = Stop.past.order(from: :desc)
    @post = Post.in_order.first
  end
end
