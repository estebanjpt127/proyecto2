class ArticlesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def new
    @article = Article.new
  end

  def create
    @article= Article.new(article_params)
    @article.user_id = current_user.id
    if @article.save
    redirect_to @article
    else
      render "new"
    end
  end

  def destroy 
    def destroy
      @article = Article.find(params[:id])
    
      if @article.user == current_user
        @article.destroy
        redirect_to articles_path, notice: 'Article was successfully deleted.'
      else
        redirect_to articles_path, alert: 'You are not authorized to delete this article.'
      end
    end
    
  end
  def show
    @article = Article.find(params[:id])
  end
 
  def index
    @articles = Article.all
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
   if @article.update(article_params)
     redirect_to @article
   else
    render "edit"
   end
  end



  private
    def set_post
      @article = Article.find(params[:id])
    end
    def article_params
      params.require(:article).permit(:title, :text)
    end 


end
