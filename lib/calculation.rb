module Calculation
  extend self
  
  def price_cal_with_qty(price, req_qty, age, offer_per)
    cost_per_product = price * req_qty
    if age > 60
      cost_per_product = cost_per_product - percent_of(offer_per, cost_per_product)
    end
    return cost_per_product
  end

  def total_cost(purchased_item)
    total = 0
    purchased_item.map{|item| total += item["price"]}
    return total
  end

  def grand_coupan(total_cost, percentage)
    total_cost - percent_of(total_cost, percentage)
  end

  def percent_of(offer_per, cost)
    cost * offer_per / 100
  end

end
