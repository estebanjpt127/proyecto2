class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    @comment.user = current_user 
  
    if @comment.save
     redirect_to article_path(@article), notice: 'Comment was successfully created.'
    else
      redirect_to article_path(@article), alert: 'Error creating comment.'
    end
  end
  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])

    if @comment.user == current_user || @article.user == current_user
     @comment.destroy
     redirect_to article_path(@article), notice: 'Comment was successfully deleted.'
   else
      redirect_to article_path(@article), alert: 'You are not authorized to delete this comment.'
    end
  end
  private
  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end
