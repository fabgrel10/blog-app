class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(post_params)
    @comment.post_id = params[:post_id]

    if @comment.save
      flash.now[:success] = 'Comment created!'
    else
      flash.now[:error] = 'Comment could not be created!'
    end
    redirect_to user_post_path(@comment.author_id, @comment.post_id)
  end

  private

  def post_params
    params.require(:comment).permit(:text)
  end
end
