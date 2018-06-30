class RestaurantsController < ApplicationController
  before_action :load_restaurant, only: [:show]
  before_action :ensure_logged_in, except: [:show, :index]
  before_action :ensure_user_owns_restaurant, only: [:edit, :destroy, :update]


  def current_capacity
    reservations.map { |r| r.party_size.to_i }.sum
  end
  
  def index
    @restaurants = Restaurant.search(params[:term])
  end

  def show
    @reservations = @restaurant.reservations
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new

    @restaurant.name = params[:restaurant][:name]
    @restaurant.price_range = params[:restaurant][:price_range]
    @restaurant.cuisine = params[:restaurant][:cuisine]
    @restaurant.open = params[:restaurant][:open]
    @restaurant.close = params[:restaurant][:close]
    @restaurant.neighbourhood = params[:restaurant][:neighbourhood]
    @restaurant.phone_number = params[:restaurant][:phone_number]
    @restaurant.capacity = params[:restaurant][:capacity]
    @restaurant.address = params[:restaurant][:address]
    @restaurant.main_picture = params[:restaurant][:main_picture]
    @restaurant.uploads = params[:restaurant][:uploads] || []
    @restaurant.user_id = current_user.id

    if @restaurant.save
      redirect_to restaurants_path
    else
      render :new
    end
  end

  def edit
    load_restaurant
  end


  def update
    load_restaurant
    @restaurant.cuisine = params[:restaurant][:cuisine]
    @restaurant.name = params[:restaurant][:name]
    @restaurant.price_range = params[:restaurant][:price_range]
    @restaurant.open = params[:restaurant][:open]
    @restaurant.close = params[:restaurant][:close]
    @restaurant.neighbourhood = params[:restaurant][:neighbourhood]
    @restaurant.phone_number = params[:restaurant][:phone_number]
    @restaurant.capacity = params[:restaurant][:capacity]
    @restaurant.address = params[:restaurant][:address]
    if params[:restaurant][:main_picture]
      @restaurant.main_picture = params[:restaurant][:main_picture]
    end

    if params[:restaurant][:uploads]
      @restaurant.uploads = params[:restaurant][:uploads] || []
    end

    if @restaurant.save
      redirect_to restaurant_path(@restaurant)
    else
      render :edit
    end
  end


  def destroy
    load_restaurant

    @restaurant.destroy
    redirect_to restaurants_path
  end

  private
  def load_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def ensure_user_owns_restaurant
    load_restaurant
    if @restaurant.user_id != current_user.id
      flash[:alert] = "Sorry you do not have access to the restaurant."
      redirect_to restaurant_path(@restaurant.id)
    end
  end




end
