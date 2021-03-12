class ItemsController < ApplicationController
  before_action :set_item, except: [:show, :edit, :update]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @items = Item.all.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if  @item.valid?
      @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    redirect_to root_path unless current_user.id == @item.user_id
  end

  def update
    @item.update(item_params)
    if  @item.valid?
      @item.save
      redirect_to item_path
    else
      render :edit
    end
  end

  private

  def set_prototype
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :image, :description, :category_id, :status_id, :burden_id, :area_id, :days_id, :price).merge(user_id: current_user.id)
  end
end