class OrdersController < ApplicationController
  before_action :set_action

  def index
    @order_destination = OrderDestination.new
  end

  def create
    @order_destination = OrderDestination.new(order_params)
    if @order_destination.valid?
      @order_destination.save
       redirect_to root_path
    else
      render :index
    end
  end


  private

  def order_params
    params.require(:order_destination).permit(:post_code, :prefecture_id, :city, :address, :building_name, :phone_number).merge(user_id: current_user.id, item_id: item.id)
  end

  def set_action
    @item = Item.find(params[:item_id])
  end

end
