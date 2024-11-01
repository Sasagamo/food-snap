class RatingsController < ApplicationController
  def new
    @rating = Rating.new()
  end

  def create
    
    if @rating = Rating.create(rating_params)
      redirect_to new_post_path
    else
      render :new,status: :unprocessable_entitiy
    end
  end

  def edit
  end

  private

  def rating_params
    params.require(:rating).permit(:rating_name).merge(user_id: current_user.id)
  end
end
