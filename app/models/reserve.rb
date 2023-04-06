class Reserve < ApplicationRecord
  belongs_to :admin
  belongs_to :order
  attribute :hour
  attribute :minutes
  before_validation do
    self.visit = Time.zone.now.change(hour: self.hour, min: self.minutes)
  end
 
  def cart_data_hash
    eval("[" + self.cart_data.gsub("} {", "}, {") + "]")
  end
end
