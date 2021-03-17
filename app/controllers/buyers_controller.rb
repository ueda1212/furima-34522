class BuyersController < ApplicationController

  def index
    @item = Item.find(params[:item_id])
    @buyer = BuyerDonation.new
  end


  def create
    @item = Item.find(params[:item_id])
    @buyer = BuyerDonation.new(buyer_donation_params)
    if  @buyer.valid?
      @buyer.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def buyer_donation_params
    params.require(:buyer_donation).permit(:post_code, :area_id, :municipality, :address, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end