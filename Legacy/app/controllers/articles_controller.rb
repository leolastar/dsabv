class ArticlesController < ApplicationController
    before_action :admin_user,     only: [:edit, :update]

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
   
    if @article.update(article_params)
      redirect_to root_path
    else
      render 'edit'
    end
  end
     
  private
    def article_params
      params.require(:article).permit(:text)
    end
end
