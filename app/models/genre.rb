class Genre < ApplicationRecord
  has_many :items
  belongs_to :admin, optional: true
end
