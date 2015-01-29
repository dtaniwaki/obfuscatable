class CommentsController < ApplicationController

  def create
    if Rails::VERSION::MAJOR >= 4
      @comment = Comment.create!(params.require(:comment).permit!)
    else
      @comment = Comment.create!(params[:comment])
    end
    redirect_to post_path(@comment.post)
  end
end
