require './lib/grocery_item'

class Customer

  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
    @groceries = GroceryItem.new
    @selected_items = Hash.new
    @selected_items[@name] = Hash.new
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

  # In welcome note, we are givnig a  and list the available item in our store
  def all_available_items
    if @welcome_count == 0
      p "Hi #{@name} Welcome to the Grocy Groceries. Please find the available items in our store"
      @welcome_count += 1
    else
      p "Please find the available items in our store!"
    end
    @groceries.listed_item.each {|key, value|
      p "Product ID: #{key}, Name: #{value['product']}, Available Qty: #{value['quantity']}, Price Per Unit: #{value['price']}"
      p "-----"
    }
    p "Press '1' to purchase (or) Press '0' to exit: "
    user_choice = gets.chomp
    if user_choice == "1"
      @selected_items = @groceries.add_to_cart(@name, @age)
      p "************"
      p "Please find your purchased items and your tolal"
      @selected_items["purchased_item"].each do |final_list|
        p "Name: #{final_list['product']}, Purchased Qty: #{final_list['quantity']}, Price: #{final_list['price']}"
      end
      p "Total amount: #{@selected_items["total"]}"
      #Call the all available items to recall the shopping option and listing the products to the customer.
      p "************"
      all_available_items
    else
      p "Thanks for shopping with us."
    end
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
