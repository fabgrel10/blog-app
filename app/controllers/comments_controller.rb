class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(post_params)
    @comment.post_id = params[:post_id]

    if @comment.save
      flash[:success] = 'Comment created!'
    else
      flash[:error] = 'Comment could not be created!'
    end
    redirect_to user_post_path(@comment.author_id, @comment.post_id)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.decrement_comments_counter
    @comment.delete
    redirect_to user_post_path(@comment.author_id, @comment.post_id), notice: 'Comment deleted!'
  end

  private

  def post_params
    params.require(:comment).permit(:text)
  end
end
