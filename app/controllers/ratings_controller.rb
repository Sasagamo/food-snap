class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
    @rating = Rating.new # 新規作成用のインスタンス
  end

  def create
    @rating = Rating.new(rating_params)
    if @rating.save
      redirect_to ratings_path, notice: "Rating created successfully"
    else
      render :index, status: :unprocessable_entity
    end
  end

  def update
    @rating = Rating.find(params[:id])
    if @rating.update(rating_params)
      redirect_to ratings_path, notice: "Rating updated successfully"
    else
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @rating = Rating.find(params[:id])
    @rating.destroy
    redirect_to ratings_path, notice: "Rating deleted successfully"
  end

  private

  def rating_params
    params.require(:rating).permit(:rating_name).merge(user_id:current_user.id)
  end
end
