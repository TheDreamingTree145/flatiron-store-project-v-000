class LineItemsController < ApplicationController

  def create
    if current_user.current_cart.nil?
      current_user.create_cart
      current_user.current_cart.add_item(params[:item_id])
    else
      current_user.current_cart.add_item(params[:item_id])
    end
    current_user.save
    redirect_to current_user.current_cart
  end
end
