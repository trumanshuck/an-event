class HomeController < ApplicationController
  def index
    @messages = [
      "Hasn't this happened already?",
      "Your cat must be real excited."
    ]
  end
end
