class ItemsController < ApplicationController
  def show
    @item = Item.find(params[:id])
  end

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
      if @item.save
        redirect_to items_path
      else
        render :new
      end
  end

  def edit

  end

  def update

  end

  def destroy
    @item = Item.delete
  end

private

  def item_params
    params.require(:item).permit(:category, :name, :price, :description)
  end

end
