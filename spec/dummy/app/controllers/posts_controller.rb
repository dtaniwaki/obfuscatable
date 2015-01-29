class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    if Rails::VERSION::MAJOR >= 4
      @post = Post.create!(params.require(:post).permit!)
    else
      @post = Post.create!(params[:post])
    end
    redirect_to @post
  end

  def show
    @post = Post.find_obfuscated(params[:id])
  end
end
