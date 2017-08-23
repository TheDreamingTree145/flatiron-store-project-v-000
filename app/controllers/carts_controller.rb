class CartsController < ApplicationController

  def show
  end

  def checkout
    @current_cart = current_user.current_cart
    Cart.checkout(current_user)
    redirect_to cart_path(@current_cart)
  end
end
