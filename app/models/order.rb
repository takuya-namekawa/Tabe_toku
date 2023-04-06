class Order < ApplicationRecord
  belongs_to :customer, optional: true
  has_many :reserves, dependent: :destroy, class_name: "Reserve"
  accepts_nested_attributes_for :reserves, allow_destroy: true
  enum payment_method: { cash: 0, credit_card: 1, transportation_money: 2, barcode: 3 }
end
