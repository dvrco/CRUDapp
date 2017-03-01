class PostsController < ApplicationController

  layout :layout_or_not

  def new
    @post = Post.new(author: session[:author])
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      session[:author] = @post.author
      flash[:notice] = "Post dodany pomyślnie."
      redirect_to posts_path
    else
      render action: 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      flash[:notice] = "Post zaktualizowany pomyślnie."
      redirect_to posts_path
    else
      render action: 'edit'
    end
  end

  def index
    @posts = Post.all
  end

  def published
    @posts = Post.where(published: true)
    render action: "index"
  end

  def show
    @post = Post.find(params[:id])
  end

  def confirm_destroy
    @post = Post.find(params[:id])  
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "Post został pomyślnie usunięty."
    redirect_to posts_path
    else
  end

  private
  def post_params
    params.require(:post).permit(:title, :author, :body, :published)
  end

  def layout_or_not
    if params[:skip_layout] == "true"
      false
    else
      'jumbotron'
    end
  end


end
