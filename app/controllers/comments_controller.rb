class CommentsController < ApplicationController
before_filter :authenticate_user!
	def destroy
		@article = Article.find(params[:article_id])
		@comment = @article.comments.find(params[:id])
		@comment.destroy
		redirect_to article_path(@article)
	end

	def create
		@article = Article.find(params[:article_id])
		@comment = @article.comments.create({commenter: current_user.email.match(/\A[^@]+/).to_s, text: params[:comment][:text] })
		redirect_to article_path(@article)
	end

	private
	def comment_params
		params.require(:comment).permit(:commenter, :text)
	end
end
