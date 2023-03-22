class Public::CustomersController < ApplicationController
  # before_action :ensure_guest_customer, only: [:edit]

  def show
    @customer = current_customer
    # @orders = @customer.orders
    # favorites = Favorite.where(customer_id: current_customer.id).pluck(:admin_id)  # ログイン中のユーザーのお気に入りのadmin_idカラムを取得
    # @favorite_list = Admin.find(favorites)     # adminsテーブルから、お気に入り登録済みのレコードを取得
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to my_page_customers_path, notice: "会員情報の更新に成功しました"
    else
      render "public/customers/edit"
    end
  end

  private
    def customer_params
      params.require(:customer).permit(:name, :name_kana, :phone_number, :email)
    end

    # def ensure_guest_customer
    #   @customer = current_customer
    #   if @customer.name == "guestcustomer"
    #     redirect_to root_path, alert: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    #   end
    # end
end
