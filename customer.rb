require './lib/grocery_item'
require './lib/coupan_code'

class Customer

  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
    @groceries = GroceryItem.new
    @selected_items = Hash.new
    @selected_items[@name] = Hash.new
    @coupan = CoupanCode.new
  end

  # If the user age is less 18 or not a valid age. We are not allowing to go further.
  def validate_age(age)
    if age.to_i < 18
      p "Please enter a valid age (Your age should me more than 18): "
      @age = gets.chomp
      validate_age(@age)
    else
      @welcome_count = 0
      all_available_items
    end
  end

  # In welcome note, we are givnig a and list the available item in our store
  def all_available_items
    wel_notes = ""
    if @welcome_count == 0
      wel_notes = "Hi #{@name} Welcome to the Grocy Groceries."
    end
    # Listing all the items
    listing_all_item(wel_notes)
    #Get input from user for continue the shopping.
    @welcome_count == 0 ? (p "Press '1' to purchase (or) Press '0' to exit: ") : (p "Press '1' to purchase (or) Press '2' if you have coupan (or) Press '0' to exit: ")
    user_choice = gets.chomp
    customer_req_status(user_choice)
  end

  def customer_req_status(user_choice)
    #if it is 1 will continue the shopping and if it is 0 quite the shopping
    case user_choice
    when "1"
      @selected_items[@name] = @groceries.add_to_cart(@name, @age)
      # List all item selected by customer
      listing_selected_item(@selected_items[@name])
      @welcome_count += 1
      all_available_items
    when "2"
      p "Please enter you coupan code: "
      get_coupan = gets.chomp
      valid_coupan = @coupan.validate_coupan(get_coupan)
      if valid_coupan == true
        @coupan.apply_offer(@selected_items[@name], get_coupan)
        p "You coupan has been applied successfully and the total is: #{@selected_items[@name]['total']}"
        customer_req_status("0")
      else
        p "*** You have entered invalid coupan, please try again. ***"
        customer_req_status("2")
      end
    when "0"
      p "Thanks for shopping with us."
    else
      p "Oops, This is not a valid one, please try again."
      all_available_items
    end
  end

  def listing_selected_item(selected_items)
    p "************"
    p "Please find your purchased items and your tolal"
    selected_items["purchased_item"].each do |final_list|
      p "Name: #{final_list['product']}, Purchased Qty: #{final_list['quantity']}, Price: #{final_list['price']}"
    end
    p "Total amount: #{selected_items["total"]}"
    #Call the all available items to recall the shopping option and listing the products to the customer.
    p "************"
  end

  def listing_all_item(wel_notes)
    p wel_notes + "Please find the available items in our store"
    #List all the grocery items
    @groceries.listed_item.each {|key, value|
      p "Product ID: #{key}, Name: #{value['product']}, Available Qty: #{value['quantity']}, Price Per Unit: #{value['price']}"
      p "-----"
    }
  end
end

# Get customer name
p "Enter your name: "
name = gets.chomp
# Get customer age
p "Enter your age(Senior citizens will get 10% discount from MRP): "
age = gets.chomp

customer = Customer.new(name, age)
customer.validate_age(age)
