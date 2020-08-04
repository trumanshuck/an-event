class HomeController < ApplicationController
  def index
    @messages = [
      "Hasn't this happened already?",
      "Catballs is extremely pleased."
    ]
  end
end
