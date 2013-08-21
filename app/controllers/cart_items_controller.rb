class CartItemsController < ApplicationController
  before_action :set_cart_item, only: [:show, :edit, :update, :destroy]

  # POST /cart_items
  def create
    @product = Product.find_by(id: params[:product_id])
    
    @cart_item = CartItem.where(cart_id: cookies[:cart_id], product_id: @product.id, image_nr: cookies[:image_nr]).first_or_create
    @cart_item.quantity = @cart_item.quantity.to_i + 1
    
    if @cart_item.save
      redirect_to "/store", notice: 'Cart item was successfully created.'
    else
      render action: 'new'
    end
  end

  # DELETE
  def delete_multiple
    ids = params[:cart_items].split(",")
    CartItem.destroy(ids)
    redirect_to store_checkout_path, notice: 'Cart items was successfully destroyed.'
  end
  
  def update_multiple
    #raise params[:cart_items].inspect
    
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
    redirect_to store_checkout_path, notice: 'Cart items was successfully destroyed.'
  end
  
  def destroy_multiple
    @cart = Cart.where(id: cookies[:cart_id]).first_or_create
    @cart.cart_items.each(&:destroy)
    
    
    redirect_to "/store", notice: 'Cart items was successfully destroyed.'
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart_item
      @cart_item = CartItem.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def cart_item_params
      params.require(:cart_item).permit(:cart_id, :product_id, :quantity, :image_nr)
    end
end
