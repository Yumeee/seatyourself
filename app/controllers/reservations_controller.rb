class ReservationsController < ApplicationController

before_action :ensure_logged_in
before_action :load_restaurant
before_action :load_reservations, except:[:index, :new, :create]
before_action :ensure_user_owns_reservation, only:[:edit, :update, :show, :destroy]
#except


    def index
        @reservations = Reservation.all
    end

    def show
    end

    def new
        @reservation = Reservation.new
    end

    def create

        @reservation = Reservation.new
        @reservation.date = params[:reservation][:date]
        @reservation.time = params[:reservation][:time]
        @reservation.party_size = params[:reservation][:party_size]
        @reservation.restaurant_id = params[:restaurant_id]
        @reservation.user = current_user

        if @reservation.save
            redirect_to restaurant_reservation_url(@restaurant, @reservation)
        else
            render :new
        end
    end

    def edit

    end

    def update
        @reservation.date       = params[:reservation][:date]
        @reservation.time       = params[:reservation][:time]
        @reservation.party_size = params[:reservation][:party_size]
        if @reservation.save
            flash[:notice] = "Reservation Successfully created"
            redirect_to restaurant_reservation_path(@restaurant ,@reservation)
        else
            render :edit
        end
    end

    def destroy
        @reservation.destroy
    end

    private

    def load_restaurant
        @restaurant = Restaurant.find(params[:restaurant_id])
    end

    def load_reservations
        @reservation = Reservation.find(params[:id])
    end

    def ensure_user_owns_reservation
        unless current_user == @reservation.user
            flash[:alert] = " You are not the owner of the reservation! "
            redirect_to new_session_path
        end
    end

  end
