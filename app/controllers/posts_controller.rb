class PostsController < ApplicationController
  before_action :set_team, only: [:show, :new, :create]
  before_action :set_category, only: [:show, :new, :create]

  def show
    @post = @category.posts.find(params[:id])
    @comment = @post.comments.build
    @comments = @post.comments
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.category_id = @category.id
    if @post.save
      redirect_to team_category_post_path(@team,@category,@post), notice: "投稿を作成しました"
    else
      render :new
    end
  end

  private

  def set_team
    @team = current_user.teams.find(params[:team_id])
  end

  def set_category
    @category = @team.categories.find(params[:category_id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
