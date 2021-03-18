class BuyersController < ApplicationController
  before_action :set_item, only: [:index, :create]
  before_action :authenticate_user!, only: [:index, :create]
  before_action :not_redirect, only: [:index, :create]
  
  def index
    @buyer = BuyerDonation.new
  end


  def create
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
  def set_item
    @item = Item.find(params[:item_id])
  end

  def buyer_donation_params
    params.require(:buyer_donation).permit(:post_code, :area_id, :municipality, :address, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: buyer_donation_params[:token],
      currency: 'jpy'
    )
  end

  def not_redirect
    redirect_to root_path if current_user.id == @item.user_id || @item.record.present?
  end
end