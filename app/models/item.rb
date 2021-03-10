class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to :category
    belongs_to :status
    belongs_to :burden
    belongs_to :area
    belongs_to :days

  with_options presence: true do
    validates :image
    validates :name
    validates :description
    validates :category_id
    validates :status_id
    validates :burden_id
    validates :area_id
    validates :days_id
    validates :price, inclusion: { in: 300..9_999_999 }, format: { with: /\A[0-9]+\z/ }
  end
   
  with_options numericality: { other_than: 1 } do
      validates :category_id
      validates :status_id
      validates :burden_id
      validates :area_id
      validates :days_id
  end

    validates :price, numericality: true

  belongs_to :user
  has_one :record
  has_one_attached :image
end
