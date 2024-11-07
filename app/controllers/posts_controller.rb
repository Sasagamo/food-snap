class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :check_user, only: [:edit, :destroy]


  def index
    @posts = Post.order(created_at: :desc)
    @posts = @posts.where(prefecture_id: params[:prefecture_id]) if params[:prefecture_id].present?
    @posts = @posts.where(genre_id: params[:genre_id]) if params[:genre_id].present?
  end

  def new
    @post= Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      create_post_ratings(@post)
      redirect_to root_path
    else
      render :new ,status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
    @post.post_ratings.each_with_index do |rating, index|
      if index < 3 
        @post.send("rating_id_#{index + 1}=", rating.rating_id)
        @post.send("score_#{index + 1}=", rating.score)
      end
    end
  end

  def update 
    if @post.update(post_params)
      update_post_ratings(@post)
      redirect_to root_path
    else
      render :edit ,status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:store_image, :store_name, :memo, :genre_id, :prefecture_id, {food_images: []}).merge(user_id:current_user.id)
  end

  def check_user
    return if @post.user == current_user
    redirect_to root_path
  end

  def create_post_ratings(post)
    # 各評価を登録します
    (1..3).each do |i|
      rating_id = params[:post]["rating_id_#{i}"]
      score = params[:post]["score_#{i}"]
      if rating_id.present? && score.present?
        post.post_ratings.create(rating_id: rating_id, score: score)
      end
    end
  end

  def update_post_ratings(post)
    (1..3).each do |i|
      new_rating_id = params[:post]["rating_id_#{i}"]
      score = params[:post]["score_#{i}"]
  
      if new_rating_id.present? && score.present?
        # `post.post_ratings`からi番目の`PostRating`レコードを取得
        post_rating = post.post_ratings[i - 1]  # インデックスを使用して取得
  
        if post_rating
          # `rating_id`と`score`の両方を更新
          post_rating.update(rating_id: new_rating_id, score: score)
        else
          # レコードがない場合、新規作成
          post.post_ratings.create(rating_id: new_rating_id, score: score)
        end
      end
    end
  end
  

end
