class BuyersController < ApplicationController

  def index
    @item = Item.find(params[:item_id])
    @buyer = BuyerDonation.new
  end


  def create
    @item = Item.find(params[:item_id])
    @buyer = BuyerDonation.new(buyer_donation_params)
    if  @buyer.valid?
      pay_item
      @buyer.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def buyer_donation_params
    params.require(:buyer_donation).permit(:post_code, :area_id, :municipality, :address, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = "sk_test_a13e8a9a8a6c9320fe467916"
    Payjp::Charge.create(
      amount: @item.price,
      card: buyer_donation_params[:token],
      currency: 'jpy'
    )
  end
end