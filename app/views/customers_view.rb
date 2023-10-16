class CustomersView < BaseView

  def display(customers)
    if customers.any?
      customers.each_with_index do |customer, index|
        puts "#{index + 1}.) #{customer.name} - #{customer.address}"
      end
    else
      puts 'No customers yet :('
    end
  end
end
