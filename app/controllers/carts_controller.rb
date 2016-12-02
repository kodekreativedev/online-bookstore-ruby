class CartsController < ApplicationController
  before_action :authenticate_user!

  def index
    @carts = current_user.carts.includes(:book)
    @total_price = total_price
  end

  def create
    current_user.create_cart(cart_params)
    redirect_back fallback_location: root_url, notice: "Added to your cart successfully."
  end

  def update
    @cart = Cart.find(params[:id])
    @cart.update(cart_params)
    redirect_back fallback_location: carts_url, notice: "Item(s) in your cart were successfully updated."
  end

  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy
    redirect_to carts_path, notice: "Item(s) in your cart were successfully deleted."
  end

  private

  def cart_params
    params.require(:cart).permit(:quantity, :book_id)
  end

  def total_price
    sum = 0
    current_user.carts.each {|cart| sum += cart.book.price * cart.quantity}
    sum
  end
end
