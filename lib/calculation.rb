module Calculation
  extend self
  
  def price_cal_with_qty(price, req_qty, age, offer_per)
    cost_per_product = price * req_qty
    if age > 60
      cost_per_product = offer_per.percent_of(cost_per_product)
    end
    return cost_per_product
  end

  def total_cost(purchased_item)
    total = 0
    purchased_item.map{|item| total += item["price"]}
    return total
  end

end


class Numeric

  def percent_of(n)
    self.to_f / n.to_f * 100.0
  end

end
