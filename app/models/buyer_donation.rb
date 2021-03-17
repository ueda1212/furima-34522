class BuyerDonation
  include ActiveModel::Model
  attr_accessor :post_code, :area_id, :municipality, :address, :building_name, :phone_number, :user_id, :item_id

  VALID_PHONE_REGEX = /\A\d{0}$|^\d{11}\z/

  with_options presence: true do
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :area_id, numericality: { other_than: 1 }
    validates :municipality
    validates :address
    validates :phone_number, format: { with: VALID_PHONE_REGEX }
  end

  def save
    record = Record.create(user_id: user_id, item_id: item_id)
    Buyer.create(post_code: post_code, area_id: area_id, municipality: municipality, address: address, building_name: building_name, phone_number: phone_number, record_id: record.id)
  end
end


