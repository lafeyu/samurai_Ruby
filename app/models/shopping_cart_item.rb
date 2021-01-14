class ShoppingCartItem < ApplicationRecord
    acts_as_shopping_cart_item
      
#user_cart_items	カートに入っているすべての商品のデータを返す。
# user_cart_item_ids	カートに入っている商品のitem_idの値を配列で返す。
# in_cart_product_names	カートに入っている商品のnameの値を配列で返す。
# set_user_cart	まだ注文が確定していないカートのデータを返し、データがなければ新しく作る。
    scope :user_cart_items, -> (user_shoppingcart) { where(owner_id: user_shoppingcart) }
    scope :user_cart_item_ids, -> (user_shoppingcart) { where(owner_id: user_shoppingcart).pluck(:item_id) }
end
