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
  updated_cart = {}
  #item = coupon[:item]
  cart.each do |item_name, item_info|
    coupons.each do |coupon|
      updated_cart["#{item_name} W/COUPON"] = {}
      updated_cart[item_name] = item_info
       
      #binding.pry
        if updated_cart.include?(coupon[:item])
          #binding.pry
          quantity = updated_cart[coupon[:item]][:count] / coupon[:num]
          multi_quanity = updated_cart[coupon[:item]][:count] % coupon[:num]
          if coupon
            updated_cart["#{item_name} W/COUPON"] = {:price => coupon[:cost], :clearance => cart[item_name][:clearance], :count => 1}
            #updated_cart["#{coupon[:item]} W/COUPON"][:count]
            #updated_cart["#{coupon[:item]} W/COUPON"][:count] += 1
            
        binding.pry
          #elsif 
            #updated_cart[coupon[:item]][:count] /= coupon[:num]
            #updated_cart["#{coupon[:item]} W/COUPON"] = {:price => coupon[:cost], :clearance => cart[item_name][:clearance], :count => quantity}
            updated_cart[item_name][:count] = multi_quanity 
          #else 
            #!coupon || !coupon.values.include?(item_name)
          #updated_cart
            
        end
      end
    end
  end
  updated_cart
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
