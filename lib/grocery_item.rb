require "./lib/calculation"

class GroceryItem

  include Calculation

  def initialize
    @available_items = {"1" => {"product" => "Oil", "quantity" => 10,"price" => 50, "offer_percentage" => 5},"2" => {"product" =>"Chips","quantity" => 50,"price" => 10, "offer_percentage" => 2},"3" => {"product" =>"Soap","quantity" => 20,"price" => 20, "offer_percentage" => 2},"4" => {"product" =>"soft_drink","quantity" => 23,"price" => 25, "offer_percentage" => 5},"5" => {"product" =>"paste","quantity" => 5,"price" => 16, "offer_percentage" => 2}}
    @customer_cart = Hash.new
    @customer_cart["purchased_item"] = Array.new
    @customer_cart["total"] = Hash.new
  end

  def listed_item
    @available_items
  end

  def add_to_cart(name, age)
    p "Please select the product using ID followed by quantities ex: 1-2, 2-6: "
    get_selected_items = gets.chomp
    if !get_selected_items.nil?
      split_product_id = []
      individual_products = get_selected_items.split(",").each{ |product| split_product_id << product.split("-") }
      get_customer_products(split_product_id, age)
      #The split_product_id is the array of [[product_id, requested_quantity]]
    else
      p 'This is not a valid selection. Please try again.'
    end
  end

  def get_customer_products(requested_products, age)
    if @customer_cart["purchased_item"].empty?
      create_new_item_cart(requested_products, age)
    else
      update_customer_cart(requested_products, age)
    end
    @customer_cart["total"] = Calculation.total_cost(@customer_cart["purchased_item"])
    #update product quantity
    update_product_quantity(@available_items, @customer_cart["purchased_item"])
    return @customer_cart
  end

  def create_new_item_cart(requested_products, age)
    requested_products.each do |prd|
      item_info = @available_items[prd[0]].dup
      item_info["quantity"] = prd[-1].to_i
      item_info["price"] = Calculation.price_cal_with_qty(item_info["price"], prd[-1].to_i, age.to_i, item_info["offer_percentage"])
      @customer_cart["purchased_item"] << item_info
      #update the available product quantity
      update_product_quantity(@available_items, prd)
    end
  end

  def update_customer_cart(requested_products, age)
    requested_products.each do |prd|
      item_info = @available_items[prd[0]].dup
      detect_product = @customer_cart["purchased_item"].detect {|f| f["product"] == item_info["product"] }
      if !detect_product.nil?
        detect_product["quantity"] = detect_product["quantity"] + prd[1].to_i
        cal_product_price = Calculation.price_cal_with_qty(item_info["price"], prd[-1].to_i, age.to_i, item_info["offer_percentage"])
        detect_product["price"] = detect_product["price"] + cal_product_price
        #update the available product quantity
        update_product_quantity(@available_items, prd)
      else
        create_new_item_cart(requested_products, age)
      end
    end
  end

  def update_product_quantity(available_items, purchased_item)
    get_product_value = @available_items.detect {|key, value| 
      value["quantity"] = value["quantity"] - purchased_item[-1].to_i if key == purchased_item[0]
    }
  end

end
