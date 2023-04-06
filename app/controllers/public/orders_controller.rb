class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def confirm
    @order = current_customer.orders.build
    @cart_items = current_customer.cart_items.joins(:item)
    admin_ids = current_customer.items.pluck(:admin_id).uniq.compact_blank
    admin_ids.each do |admin_id|
      cart_items = @cart_items.where(items: { admin_id: admin_id }).select("items.*, cart_items.*").pluck(:id, :amount, :half_price, :name)
      total_payment = cart_items.map { |o| o[1] * o[2] }.sum
      cart_data = cart_items.map { |o| { id: o[0], amount: o[1], half_price: o[2], name: o[3] } }
      @order.reserves.build(admin_id: admin_id, total_payment: total_payment, cart_data: cart_data)
    end
  end

  def create
    p @order = current_customer.orders.build(order_params)
    p @order.reserves
    @order.save!
    redirect_to thanks_path
  end

  def thanks
    current_customer.cart_items.destroy_all
  end

  def index
    @orders = current_customer.orders
  end

  def responsive
    @orders = current_customer.orders
  end

  private
    def order_params
      params.require(:order).permit(:customer_id, :payment_method, reserves_attributes: [:admin_id, :visit, :total_payment, :visit_status, :hour, :minutes, :cart_data])
    end
end
