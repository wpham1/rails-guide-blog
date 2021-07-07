# this controller accesses the articles to create comments
class CommentsController < ApplicationController
      # user must be authenticated only on destroy
    http_basic_authenticate_with name: "yaboi", password: "secret", only: :destroy
    
    def create
        # finds the article id
        @article = Article.find(params[:article_id])
        # creates a comment on that article
        @comment = @article.comments.create(comment_params)
        # redirects back to the article page
        redirect_to article_path(@article)
    end

    def destroy
        # finds the article id first
        @article = Article.find(params[:article_id])
        # then finds that specific comment id
        @comment = @article.comments.find(param[:id])
        # destroys the comment
        @comment.destroy
        # then redirects you back to the same page sans comment
        redirect_to article_path(@article)
    end


    private
    # comment requires commenter and body
    def comment_params
        params.require(:comment).permit(:commenter, :body, :status)
    end
end
