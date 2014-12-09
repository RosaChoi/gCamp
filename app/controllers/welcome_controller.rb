class WelcomeController < ApplicationController
  def home
    @quotes = Quote.all
  end
end
