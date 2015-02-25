class CartItemsController < ApplicationController
  before_action :set_cart_item, only: [:show, :edit, :update, :destroy]

  def create
    @product = Product.find_by(id: params[:product_id])

    @cart_item = CartItem.where(cart_id: cookies[:cart_id], product_id: @product.id, image_nr: cookies[:image_nr]).first_or_create
    @cart_item.quantity = @cart_item.quantity.to_i + 1

    if @cart_item.save
      redirect_to store_path, notice: t('cart_items.create.notice')
    else
      render action: 'new'
    end
  end

  def delete_multiple
    ids = params[:cart_items].split(",")
    CartItem.destroy(ids)

    redirect_to store_checkout_path, notice: t('cart_items.delete_multiple.notice')
  end

  def update_multiple
    if params[:cart_items]
      params[:cart_items].each do |k,v|

        cart_item = CartItem.find(k)

        if v.to_i > 0
          cart_item.update(quantity: v)
        else
          cart_item.destroy
        end
      end
    end

    redirect_to store_checkout_path, notice: t('cart_items.update_multiple.notice')
  end

  def destroy_multiple
    @cart = Cart.where(id: cookies[:cart_id]).first_or_create
    @cart.cart_items.each(&:destroy)

    redirect_to store_path, notice: t('cart_items.destroy_multiple.notice')
  end

  private

  def set_cart_item
    @cart_item = CartItem.find(params[:id])
  end

  def cart_item_params
    params.require(:cart_item).permit(:cart_id, :product_id, :quantity, :image_nr)
  end
end
