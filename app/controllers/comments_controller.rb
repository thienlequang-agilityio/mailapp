class CommentsController < ApplicationController
 
  def create
      @post = Post.find(params[:post_id])
      @comment = @post.comments.create(comments_params)

      CommentMailer.comment_created(current_user, @post.user, @comment.content).deliver
      redirect_to post_path(@post)
  end
 
 
  private
 
  def comments_params
     params.require(:comment).permit(:content)
  end
 
 
end