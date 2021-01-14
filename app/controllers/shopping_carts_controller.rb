class ShoppingCartsController < ApplicationController
 before_action :set_cart, only: %i[index create destroy]
  
  def index
    @user_cart_items = ShoppingCartItem.user_cart_items(@user_cart)
    @user_cart_items_count = ShoppingCartItem.user_cart_items(@user_cart).count
    @user_cart_item_ids = ShoppingCartItem.user_cart_item_ids(@user_cart)
    @product_names = Product.in_cart_product_names(@user_cart_item_ids)
    # @total = @user_cart.totalの部分では、
    # acts_as_shoppingで用意されているtotalメソッドを使用し、
    # カートの合計金額を@totalに代入
    @total = @user_cart.total
  end
  
    def show
    @cart = ShoppingCart.find(user_id: current_user)
    end
    
    def create
    @product = Product.find(product_params[:product_id])
    @user_cart.add(@product, product_params[:price].to_i, product_params[:quantity].to_i)
    redirect_to product_url(@product)
    end
    
    def update
    end
    
    def destroy
    # @user_cart.buy_flag = trueでカートの注文済みフラグをtrueにして、注文処理を行う
    @user_cart.buy_flag = true
    # カートのデータをデータベースに保存し、リダイレクトさせる
    @user_cart.save
    redirect_to cart_users_url
    end
    
    private
    def product_params
      params.permit(:product_id, :product, :price, :quantity)
    end

    def set_cart
      @user_cart = ShoppingCart.set_user_cart(current_user)
    end
  
end
# @user_cart_items	カートに入っているすべての商品データ
# @user_cart_items_count	カートに入っている商品数
# @user_cart_item_ids	カートに入っている商品idのリスト
# @product_names	カートに入っている商品名のリスト
# @total	カートの合計金額
# @user_cart	まだ注文が確定していないカートのデータ
