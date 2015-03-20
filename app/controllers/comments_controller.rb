class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  def new
  	@comment = @item.comments.build
  end

  def create
  	@comment = @item.comments.build(comment_params)
  	if @comment.save
  		redirect_to @item
  	else
  		redirect_to :new
  	end
  end

  def edit
  	@comment = @item.comments.find (params[:id])
  	if @comment.user != current_user
  		redirect_to @item, notice: "You are not authorized to edit this comment."
  	end
  end

  def update
  	@comment = @item.comments.find (params[:id])
  	if @comment.update(comment_params)
  		redirect_to @item
  	else
  		render :edit
  	end
  end

  def destroy
  	@comment = @item.comments.find (params[:id])
  	if @comment.user == current_user
  		@comment.destroy
  	else
  		redirect_to @item, notice: "You are not authorized to delete this comment."
  	end
  end

  private

  def comment_params
  	params.require(:comment).permit(:body, :user_id, :item_id)
  end

  def set_item
  	@item = Item.find(params[:item_id])
  end
end
