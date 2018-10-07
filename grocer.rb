require "pry"

def consolidate_cart(cart)
  proper_cart = {}
  cart.each do |item_hash| 
    item_hash.each do |name, info| 
      if !proper_cart[name]
        proper_cart[name] = {}
      end
      if !proper_cart[name][info] 
        proper_cart[name] = info
      end
      if !proper_cart[name][:count]
        proper_cart[name][:count] = 1
      else
        proper_cart[name][:count] += 1
      end
    end   
  end
  proper_cart
end

def apply_coupons(cart, coupons) 
  coupons.each do |coupon_hash|
    item = coupon_hash[:item] # save the coupon hash {:item=>"AVACADO, :num=>2, :const=>5.0}"}
      if cart.has_key?(item)
        origional_qty = cart[item][:count]
        coupon_qty = origional_qty / coupon_hash[:num] # this is the applied coupon qty
        new_remaining_qty_after_coupon_applied = origional_qty % coupon_hash[:num]
          if coupon_qty > 0
            cart[item][:count] = new_remaining_qty_after_coupon_applied
            cart["#{item} W/COUPON"] = {
            :price=> coupon_hash[:cost],
            :clearance=> cart[item][:clearance],
            :count=> coupon_qty }
          end
        end
      end
    cart
  #binding.pry
end

def apply_clearance(cart)
  cart.each do |item, item_info|
    if item_info[:clearance] == true
      item_info[:price] = (item_info[:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  total_cost = 0
  updated_cart = consolidate_cart(cart)
  apply_coupons(updated_cart, coupons)
  apply_clearance(updated_cart)
  updated_cart.each do |name,info|
    total_cost = updated_cart[info][:price] * updated_cart[info][:count]
    if total_cost > 100
      total_cost *= 0.9
    end
  end
  total_cost
  #binding.pry
end
