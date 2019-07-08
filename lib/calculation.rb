module Calculation

  def self.price_cal_with_qty(price, req_qty, age, offer_per)
    cost_per_product = price * req_qty.to_i
    if age > 60
      cost_per_product = cost_per_product.percent_of(offer_per)
    end
  end

  def self.total_cost(purchased_item)
    total = 0
    purchased_item.map{|item| total += item["price"]}
    return total
  end

  def percent_of(n)
    self.to_f / n.to_f * 100.0
  end

end
