require_relative 'base_view'

class OrdersView < BaseView

  def display(orders)
    if orders.any?
      orders.each_with_index do |order, index|
        puts "#{index + 1}.) #{order.meal.name} - #{order.meal.price}"
        puts "------Customer: #{order.customer.name} - #{order.customer.address}"
        puts "------Rider: #{order.employee.username} - #{order.delivered? ? "Delivered!" : "Non Delivered"}"
      end
    else
      puts 'No orders yet :('
    end
  end
end
