class ArticlesController < ApplicationController
  # user must be authenticated on every action except index and show
  http_basic_authenticate_with name: "yaboi", password: "secret", except: [:index, :show]

  # show all articles in one page
  def index
    @articles = Article.all
  end
  # shows one article in one page depending on their id
  def show
    @article = Article.find(params[:id])
  end
  # instantiates a new article form but doesn't save it, it is used in the view when building the form
  def new
    @article = Article.new
  end
  # instantiates a new article with title/body values and tries to save it.
  def create
    @article = Article.new(article_params)
    # if the article can save, it will redirect to [show] "http://localhost:3000/articles/#{@article.id}"
    if @article.save
      redirect_to @article
    else
      # Else, the action redisplays the form by rendering app/views/articles/new.html.erb
      render :new
    end
  end
    
    def edit
      # find the article id to edit
      @article = Article.find(params[:id])
    end
    def update
      @article = Article.find(params[:id])
      # if update is successful redirect to the updated article
      if @article.update(article_params)
        redirect_to @article
      else
        render :edit
      end
    end
    
    def destroy
      # finds the article from its id, then deletes it
      @article = Article.find(params[:id])
      @article.destroy
      # once deleted redirects back to the root/index
      redirect_to root_path
    end
  
  # stops people being able to break data
  private
  
  # this is used in our create method article.new so that malicious users dont overwrite private data
  def article_params
    params.require(:article).permit(:title, :body, :status)
  end
end
