class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_action

  def index
    if @item.user.id == current_user.id
        redirect_to root_path
    elsif @item.order.present? 
      redirect_to root_path
    else
    @order_destination = OrderDestination.new
    end
  end

  def create
    @order_destination = OrderDestination.new(order_params)
    if @order_destination.valid?
      pay_item
      @order_destination.save
       redirect_to root_path
    else
      render :index
    end
  end


  private

  def order_params
    item = Item.find(params[:item_id])
    params.require(:order_destination).permit(:post_code, :prefecture_id, :city, :address, :building_name, :phone_number).merge(user_id: current_user.id, item_id: item.id, token: params[:token])
  end

  def set_action
     @item = Item.find(params[:item_id])
   end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,  
      card: order_params[:token],    
      currency: 'jpy'
    )
  end

end
