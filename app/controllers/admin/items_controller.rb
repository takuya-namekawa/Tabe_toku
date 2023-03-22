class Admin::ItemsController < ApplicationController
  def index
    @item = Item.new
    @items = Item.all
    @genres = Genre.all
  end

  def create
    @item = Item.new(item_params)
    @item.admin_id = current_admin.id
    @item.save
    redirect_to admin_items_path
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to admin_items_path
  end

  def edit
    @item = Item.find(params[:id])
    if @item.admin != current_admin
      redirect_to root_path, alert: "不正なアクセスです"
    end
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    redirect_to admin_items_path
  end

  private
    def item_params
      params.require(:item).permit(:genre_id, :admin_id, :name, :explanation, :half_price, :price, :inventory, :is_ordered, :image)
    end
end
