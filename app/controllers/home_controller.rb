class HomeController < ApplicationController
  def index
    @messages = [
      "Hasn't this happened already?",
      "Catballs is extremely pleased."
    ]

    @stops = Stop.all.order(from: :desc)
  end
end
