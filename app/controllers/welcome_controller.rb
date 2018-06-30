class WelcomeController < ApplicationController
  def index
    @restaurants = Restaurant.all
    @featured_restaurants = Restaurant.all.limit(4)
  end
end
