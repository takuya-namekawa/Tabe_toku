class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :items, dependent: :destroy
  has_many :genres, dependent: :destroy
  has_many :reserves, dependent: :destroy
  
  has_one_attached :image

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join("app/assets/images/no-image.png")
      image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
end
