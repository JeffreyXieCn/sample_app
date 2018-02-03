class CommentsController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy]
  before_action :correct_user,   only: :destroy
    
  def create # TODO: Display invalid comment message in AJAX way
    @micropost = Micropost.find(params[:micropost_id])
    comment = @micropost.comments.build(comment_params)
    # @comment.update_attribute(:user_id, current_user.id)
    comment.user = current_user
    result = comment.save
    respond_to do |format|
      format.html do
        if result
          flash[:success] = 'Comment created!'
        else
          flash[:danger] = "Invalid comment: #{comment.errors.full_messages}"
        end
        redirect_back(fallback_location: root_url)
      end

      format.js { render template: 'comments/afterAction'}
    end

    
  end
  
  def destroy
    @micropost = @comment.micropost
    @comment.destroy
    respond_to do |format|
      format.html do
        flash[:success] = 'Comment deleted'
        redirect_back(fallback_location: root_url)
      end

      format.js { render template: 'comments/afterAction'}
    end
  end
  
  private

    def comment_params
      params.require(:comment).permit(:content)
    end
    
    def correct_user
      @comment = current_user.comments.find_by(id: params[:id])
      redirect_to root_url if @comment.nil?
    end
end
