class PostsController < ApplicationController
  

  def index
    @posts = Post.order(created_at: :desc)
  end

  def new
    @post= Post.new
  end

  def create
    binding.pry
    @post = Post.new(post_params)
    if @post.save
      create_post_ratings(@post)
      redirect_to root_path, notice: '投稿が成功しました。'
    else
      render :new ,status: :unprocessable_entity
    end
  end

  def show
    @post =Post.find(params[:id])
  end

  def edit
    @post =Post.find(params[:id])
    rating_id_1:post.rating
  end

  def destroy
    @post =Post.find(params[:id])
    @post.destroy
    redirect_to root_path
  end

  private
  def post_params
    params.require(:post).permit(:store_image, :store_name, :memo, :genre_id, :prefecture_id, {food_images: []}).merge(user_id:current_user.id)
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

end
