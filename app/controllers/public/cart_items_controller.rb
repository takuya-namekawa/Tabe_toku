class Public::CartItemsController < ApplicationController
 before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items
    @cart_items.each do |cart_item|  # indexで特定の情報を取りたい場合はeach文を使う
      if !cart_item.amount_status    # 新しくカラムを追加　amount_status  在庫数を減らすためにboolean型で管理
        cart_item.update(amount_status: true)  # indexページへアクセスする度に在庫数が減るのを防ぐ処理
        cart_item.item.update(inventory: (cart_item.item.inventory - cart_item.amount))  # 買い物カゴに入っている数量から商品の在庫数を引く
        if cart_item.item.inventory == 0
          cart_item.item.update(is_ordered: false)
        end
      end

      @total_price = 0
      @cart_items.each do |cart_item|
        @total_price += (cart_item.item.half_price).floor * cart_item.amount
      end
    end
    @items = Item.all.order(created_at: :desc)
  end

  def create
    @cart_item = CartItem.find_by(customer_id: current_customer.id, item_id: params[:cart_item][:item_id])
    if @cart_item.present?
      new_amount = @cart_item.amount + params[:cart_item][:amount].to_i
      @cart_item.update(amount: new_amount)
      redirect_to cart_items_path
    else
      @cart_item = CartItem.new(cart_item_params)
      @cart_item.customer_id = current_customer.id
      @cart_item.save
      redirect_to cart_items_path
    end
  end


  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.item.update(inventory: (cart_item.item.inventory + cart_item.amount))
    if cart_item.item.inventory > 0  # 商品を取り消しで戻した際在庫数を戻す
      cart_item.item.update(is_ordered: true)
    end
    cart_item.destroy

    redirect_to cart_items_path
  end

  def all_destroy
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  private
    def cart_item_params
      params.require(:cart_item).permit(:amount, :item_id, :customer_id)
    end
end
