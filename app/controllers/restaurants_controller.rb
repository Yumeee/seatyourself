class RestaurantsController < ApplicationController
  def index
  end

  def new
    @restaurant = Restaurant.new
  end

  def show
    load_restaurant
  end 

  def create
    @restaurant = Restaurant.new

    @restaurant.name = params[:restaurant][:name]
    @restaurant.phone_number = params[:restaurant][:phone_number]
    @restaurant.capacity = params[:restaurant][:capacity]
    @restaurant.address = params[:restaurant][:address]

    if @restaurant.save
      redirect_to '/restaurants'
    else
      render :new
    end
  end

  def edit
    load_restaurant

    @restaurant.name = params[:restaurant][:name]
    @restaurant.phone_number = params[:restaurant][:phone_number]
    @restaurant.capacity = params[:restaurant][:capacity]
    @restaurant.address = params[:restaurant][:address]

    if @restaurant.save
      redirect_to restaurant_path
    else
      render :edit
    end
  end

  def update
    @restaurant.main_picture = params[:restaurant][:main_picture]
    @restaurant.uploads = params[:restaurant][:uploads] || []
    load_restaurant
  end



  def destroy
    load_restaurant
    @restaurant.destroy
    redirect_to restaurants_path
  end

  def load_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def ensure_user_owns_restaurant
  end

end
