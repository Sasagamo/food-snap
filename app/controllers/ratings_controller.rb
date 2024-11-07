class RatingsController < ApplicationController
  before_action :set_ratings,only: [:index,:create,:update]

  def index
    @ratings = Rating.where(user_id:current_user.id)
    @rating = Rating.new 
  end

  def create
    @rating = Rating.new(rating_params)
    if @rating.save
      redirect_to ratings_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  def update
    @rating = Rating.find(params[:id])
    if @rating.update(rating_params)
      redirect_to ratings_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @rating = Rating.find(params[:id])
    @rating.destroy
    redirect_to ratings_path
  end

  private

  def rating_params
    params.require(:rating).permit(:rating_name).merge(user_id:current_user.id)
  end

  def set_ratings
    @ratings = Rating.where(user_id:current_user.id)
  end
end
