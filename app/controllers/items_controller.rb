class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_action, except: [:index, :new, :create]

  def index
    @items = Item.order("created_at DESC")
  end

  def new
    @item = Item.new
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    unless @item.user.id == current_user.id
      redirect_to root_path
    end
    if @item.order.present? 
      redirect_to root_path
     end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    if @item.user.id == current_user.id
      if @item.destroy
        redirect_to root_path
      end
    end
  end

  private

 def item_params
   params.require(:item).permit(:name, :price, :description, :category_id, :item_condition_id,
    :prefecture_id, :shipping_fee_id, :shipping_date_id, :image).merge(user_id: current_user.id)
 end

 def set_action
  @item = Item.find(params[:id])
end

end
